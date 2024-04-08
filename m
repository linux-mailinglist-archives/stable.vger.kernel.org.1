Return-Path: <stable+bounces-37225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBE889C3EC
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE561C2220F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67F80BE7;
	Mon,  8 Apr 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W0UXiRMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA680639;
	Mon,  8 Apr 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583614; cv=none; b=YydVvT81jd/LnPiQW+u4FIgc+r0NW5J3TCo7+7TCFKQ1kB1bPXzH9J1g0UjaxKQ51igZEnMzt898sJGz5io6fFegD5G7OyLJAkpEBoLpcGbdN8Tk0dqC4BvSBavDwUQeCCdMNfd5dd4hLBRZb9Kdte0q1739i9raZ0wVBOIIyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583614; c=relaxed/simple;
	bh=6m1TG3Wx+brqWHzfbn4WMNZtXJaI4DkkW+S0bFl9zhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X64HVS85aAhs0Cte7oxXcTcfAOuTCdmCqAYVohZBO7XQI7ndHxPYPZqqwYBhU2UmIYhnz8jjpsuNP1MK8nRbw+6W5D2wlu3foiFAnEmk9AnlSrfUq0G+r92zbJt/sJ4AWduLLupSjAv85Y7EPLu3wB5hmKGQi1+Gizejcz+5rUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W0UXiRMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E02C433C7;
	Mon,  8 Apr 2024 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583614;
	bh=6m1TG3Wx+brqWHzfbn4WMNZtXJaI4DkkW+S0bFl9zhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0UXiRMrSP4c5yXnH06ic1GJI1hWro8IW1FFh1eqvQrbEkibsiujcxNEV+VIcrfsb
	 KPZsv+YPYsjdRBfu4ln4iglrM07mr7HDRhotCnWBlbgPlwCwLDlLSZthREKaZPk4Ik
	 8jUON27/CYlTLUWcz0IRKdwWF8sX5s+Zo6rM3AGE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.8 201/273] ALSA: hda: Add pplcllpl/u members to hdac_ext_stream
Date: Mon,  8 Apr 2024 14:57:56 +0200
Message-ID: <20240408125315.566234771@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit f9eeb6bb13fb5d7af1ea5b74a10b1f8ead962540 upstream.

The pplcllpl/u can be used to save the Link Connection Linear Link
Position register value to be used for compensation of the LLP register
value in case the counter is not reset (after pause/resume or
stop/start without closing the stream).

The LLP can be used along with PPHCLDP to calculate delay caused by the DSP
processing for HDA links.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240321130814.4412-17-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/sound/hdaudio_ext.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index a8bebac1e4b2..957295364a5e 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -56,6 +56,9 @@ struct hdac_ext_stream {
 	u32 pphcldpl;
 	u32 pphcldpu;
 
+	u32 pplcllpl;
+	u32 pplcllpu;
+
 	bool decoupled:1;
 	bool link_locked:1;
 	bool link_prepared;
-- 
2.44.0




