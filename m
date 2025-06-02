Return-Path: <stable+bounces-149833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BA6ACB4BC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E584A5225
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E01227EB9;
	Mon,  2 Jun 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NK7rThRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674B227EAE;
	Mon,  2 Jun 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875184; cv=none; b=VAMIky1XB+Es06CK4AbMQdbnH4Px+/xVLrqQAPCKwbcEfuYUUq4ViJzNQQEw6WGlkc4FRXXgzqPXcIE/M1ZuQ4THFgrns43ac1PQIouePQnaQa8LtfIOxOTY27dL3TuGMr8aCDMpv/7VmdPou6o4jy3y5Wr/0bF17hoLbEUZ9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875184; c=relaxed/simple;
	bh=rvBsnqiRATOCJq4Jw0Xy4zAIkAualGVM99Ke03RLd4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+OtYaEwR5Xnm/kKfSKKwQ4gzN6a/2hFOqAMe/Du58dUCwiQDWFwBWjmo7KM8DW8V1Ijq5JsreaShJTuJmOdP4ZJHPc/aDqQdxZCpPhLD0jcpWXIEM2+mx61D3OiwFFoNocuQzOa4DAwjlZl/ZOHE3uwYM8SimdGCsaia5MZinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NK7rThRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E72C4CEEB;
	Mon,  2 Jun 2025 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875184;
	bh=rvBsnqiRATOCJq4Jw0Xy4zAIkAualGVM99Ke03RLd4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NK7rThRJPpadQNolEU29n79L7nRZWemi7NoMTvMQBUZYV1qnY49eUYWLNnYt2S39q
	 /Jq5j4opjn+Zr0eoxkIZa+Wli44+KO253Mu9zKnm7sV8f0IhAx7oJ5BCwBwRMf/ZD3
	 U2PTAsvECZlMAdldBc7i2z+VFEUgopNWxSvGo+l8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	jt <enopatch@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.10 054/270] Input: synaptics - enable SMBus for HP Elitebook 850 G1
Date: Mon,  2 Jun 2025 15:45:39 +0200
Message-ID: <20250602134309.406783173@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit f04f03d3e99bc8f89b6af5debf07ff67d961bc23 upstream.

The kernel reports that the touchpad for this device can support
SMBus mode.

Reported-by: jt <enopatch@gmail.com>
Link: https://lore.kernel.org/r/iys5dbv3ldddsgobfkxldazxyp54kay4bozzmagga6emy45jop@2ebvuxgaui4u
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -188,6 +188,7 @@ static const char * const smbus_pnp_ids[
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2068", /* T14 Gen 1 */
+	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3015", /* HP EliteBook 840 G2 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */



