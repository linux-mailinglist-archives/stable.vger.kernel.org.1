Return-Path: <stable+bounces-157812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACCEAE55A8
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6123E7A1ED7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE79227E97;
	Mon, 23 Jun 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ekHfVsa0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F303223DD0;
	Mon, 23 Jun 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716779; cv=none; b=Nhk8YshaX34aiRF0ADy1pcEcIhjYzdDm9vQYKB/oyOgJw7+3eYOxbU2D8Ae9tvExWi+cj7M65k7eUX4xyZiDw9jsbCFibam0nSfe1VXMP/ybPgz/TPkJ0RMc7MU0fUCWQTBMLxweYtkHr1pmzEip+0mD+g+p0aK9Qb69RX0ixZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716779; c=relaxed/simple;
	bh=R09hTtvCR0F1D2oKh8qfe0w+SQM+B7SfDFqqtV6DgY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1QFZAhsbZ984ZH2Ge6EOZBsUGS0JeX+HVUeaFDk4wDsAs4aA4SLQH/f9Zfd9WM9hXSAqG9RnjVSxcl3q+n/MFef8TO09S6heZqPlQ3S6U1dIoIHmGj0vHVrPc6mrot3yjKGUfNbYEqNdyW8+DgIoEN+NG/vKLEBA+YtDUz9DMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ekHfVsa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF8DC4CEEA;
	Mon, 23 Jun 2025 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716779;
	bh=R09hTtvCR0F1D2oKh8qfe0w+SQM+B7SfDFqqtV6DgY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekHfVsa0/+VQJhTG/iyvr7PJ7K2VHpx/y7FMELPTPShY78+RnWhAHKmMEClYSuKVO
	 MV4DlAelsyy3/HkVrmhyWLowRLhtngEmSIf1XUPz4uRg0LlNheNqG1TkNYArmsk8/H
	 /nlbHqylEElpBB9WVz9Qk1HYbCRz9AaWszEScFQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	WangYuli <wangyuli@uniontech.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.15 357/411] Input: sparcspkr - avoid unannotated fall-through
Date: Mon, 23 Jun 2025 15:08:21 +0200
Message-ID: <20250623130642.631165559@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WangYuli <wangyuli@uniontech.com>

commit 8b1d858cbd4e1800e9336404ba7892b5a721230d upstream.

Fix follow warnings with clang-21i (and reformat for clarity):
  drivers/input/misc/sparcspkr.c:78:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     78 |                 case SND_TONE: break;
        |                 ^
  drivers/input/misc/sparcspkr.c:78:3: note: insert 'break;' to avoid fall-through
     78 |                 case SND_TONE: break;
        |                 ^
        |                 break;
  drivers/input/misc/sparcspkr.c:113:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    113 |                 case SND_TONE: break;
        |                 ^
  drivers/input/misc/sparcspkr.c:113:3: note: insert 'break;' to avoid fall-through
    113 |                 case SND_TONE: break;
        |                 ^
        |                 break;
  2 warnings generated.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
Link: https://lore.kernel.org/r/6730E40353C76908+20250415052439.155051-1-wangyuli@uniontech.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/sparcspkr.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -74,9 +74,14 @@ static int bbc_spkr_event(struct input_d
 		return -1;
 
 	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
+	case SND_BELL:
+		if (value)
+			value = 1000;
+		break;
+	case SND_TONE:
+		break;
+	default:
+		return -1;
 	}
 
 	if (value > 20 && value < 32767)
@@ -112,9 +117,14 @@ static int grover_spkr_event(struct inpu
 		return -1;
 
 	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
+	case SND_BELL:
+		if (value)
+			value = 1000;
+		break;
+	case SND_TONE:
+		break;
+	default:
+		return -1;
 	}
 
 	if (value > 20 && value < 32767)



