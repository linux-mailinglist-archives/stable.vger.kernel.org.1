Return-Path: <stable+bounces-97204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68FA9E2A40
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52674B34EA8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D61F707A;
	Tue,  3 Dec 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J99RV/qz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE892500DA;
	Tue,  3 Dec 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239815; cv=none; b=lzoYD2zXHmPYecEbxM9U+rhERFzp5m7SwI+8SFa9So9w68ClGF4zic96ypDb+lxr4FxdPjaAJBcZLaqu7TNnrIhEPWX8QrYFBS2g0EGbok5KyRpc0zxdOUHd9OHsdll3Isd5LU/t1Cv+JbVz8LpDx9R7/1/UAiQabY3E4l/x54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239815; c=relaxed/simple;
	bh=GhoZ/2YaSdTOrxT0oGgLg6UfO8NrfjKOH0Ia1kXxSeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGFwb3E95Pt0pKj5WoKEkWFVLvmSANIybbcxqJtcFNpxXBKBDd4EzDErY8YEXrEHpBa8I6SR+xWiUy8gKI3ygz/Eg+f4JfvUPBpciVRvhYXiyzxjPcxCsTyRXlCpB6E97VHaNCDfr+4SO0UoElrgrEwoZGvj7fO9yKNlTBO5p2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J99RV/qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97781C4CECF;
	Tue,  3 Dec 2024 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239815;
	bh=GhoZ/2YaSdTOrxT0oGgLg6UfO8NrfjKOH0Ia1kXxSeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J99RV/qzhCXAuVALTSFg75CnIYlzSB9CHU06CBkmAXpt+5lJsQM9etYzkQVnJ0r1i
	 fQWFWCIqQA1YSMevKYMmcNeeYLUzzAtwtyR/7BB5PFO1+BJyJaExAxQVDA5VLikHPK
	 BNNQlAlqRVUYKFMoFM4X8Pb+vtfCxY/dG6YdhOrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.11 742/817] ALSA: hda/realtek: Set PCBeep to default value for ALC274
Date: Tue,  3 Dec 2024 15:45:14 +0100
Message-ID: <20241203144024.961245238@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 155699ccab7c78cbba69798242b68bc8ac66d5d2 upstream.

BIOS Enable PC beep path cause pop noise via speaker during boot time.
Set to default value from driver will solve the issue.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/2721bb57e20a44c3826c473e933f9105@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -473,6 +473,8 @@ static void alc_fill_eapd_coef(struct hd
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
+		alc_write_coef_idx(codec, 0x6e, 0x0c25);
+		fallthrough;
 	case 0x10ec0294:
 	case 0x10ec0700:
 	case 0x10ec0701:



