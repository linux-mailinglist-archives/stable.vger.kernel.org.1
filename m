Return-Path: <stable+bounces-9854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEE8255B9
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E81C23130
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774212D7B5;
	Fri,  5 Jan 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LPDyJwJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC328FA;
	Fri,  5 Jan 2024 14:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7115C433C7;
	Fri,  5 Jan 2024 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465714;
	bh=jDgRi60wvvvbGoo4yi0mptEKtmi2cS1ahl6Rc7wOm3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPDyJwJRNo3Dmf4Z3WJsaT8DbYaZK2se4ARu5mZYXdzn68SaqdZwZyEprMRm0/B3V
	 0GTYhDIm2NJovlTGbLNwAwY3ZqyyenpqBq3dEui/ub9Z6X873dFpeuM4veUkGVGdit
	 GRIwzgliKTG2U/z+ZM8j+1AaQZ4r/f5fIj8DVa74=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 28/41] wifi: cfg80211: fix certs build to not depend on file order
Date: Fri,  5 Jan 2024 15:39:08 +0100
Message-ID: <20240105143815.135634414@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
References: <20240105143813.957669139@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 3c2a8ebe3fe66a5f77d4c164a0bea8e2ff37b455 upstream.

The file for the new certificate (Chen-Yu Tsai's) didn't
end with a comma, so depending on the file order in the
build rule, we'd end up with invalid C when concatenating
the (now two) certificates. Fix that.

Cc: stable@vger.kernel.org
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: fb768d3b13ff ("wifi: cfg80211: Add my certificate")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/certs/wens.hex |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/certs/wens.hex
+++ b/net/wireless/certs/wens.hex
@@ -84,4 +84,4 @@
 0xf0, 0xc7, 0x83, 0xbb, 0xa2, 0x81, 0x03, 0x2d,
 0xd4, 0x2a, 0x63, 0x3f, 0xf7, 0x31, 0x2e, 0x40,
 0x33, 0x5c, 0x46, 0xbc, 0x9b, 0xc1, 0x05, 0xa5,
-0x45, 0x4e, 0xc3
+0x45, 0x4e, 0xc3,



