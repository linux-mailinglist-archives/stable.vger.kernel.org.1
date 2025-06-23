Return-Path: <stable+bounces-156514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ECCAE4FDE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F361B61CCF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8802628C;
	Mon, 23 Jun 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P1lkR62N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A57482;
	Mon, 23 Jun 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713600; cv=none; b=WMP61LD0OfdnEG7R68VGZujFhq0HXvcYJiKb28HEstv9TahoM4m2N5HgX1Bn/nfKcpMyCofDuOWtRznJrvAnFVE+YVUIZLOKlW4q3ZeEHeaHOcdaUUpI7BpqJppCkAs/Viqga5G/e9wiCmeSxmUlu6rowdBO+dDzOMBtJcIkl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713600; c=relaxed/simple;
	bh=k3tk2kV5pw81kwJkZRoPMGRVoYvWmK1NobW9Oy/RPZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Czf+VxVW5mHKJrhT3X2bFkyH+Ep3R7tG1N4RcHy12jL5oVLOsmuf/APtLA4XS8l8BQqC6+Yfx8WFojUh8WctuJhgk0REKFWUEtHwV6/8mdgP9/kwSwXHooOkiuk+HvaYY1QQNpEWR2fIJfxBOGp0r5flp+P4g0IQxuagEhSLHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P1lkR62N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A855C4CEEA;
	Mon, 23 Jun 2025 21:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713599;
	bh=k3tk2kV5pw81kwJkZRoPMGRVoYvWmK1NobW9Oy/RPZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1lkR62NbXuQ8ZHhyAsceRJzy87ZORGUsHXXpj90Eb/KZ9QVKnjUEOkQGBGpVEwU0
	 dWUetHb23XG/gQ8oNQ+d7YVYVdLmj2qVCc8zP07c85wP4NEHECFq2t5JdbIeMUF1fk
	 GQf6XJXCy+X+16vdxgRQxTQIaJprGLP/yVjdmGWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	WangYuli <wangyuli@uniontech.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.4 195/222] Input: sparcspkr - avoid unannotated fall-through
Date: Mon, 23 Jun 2025 15:08:50 +0200
Message-ID: <20250623130618.094956393@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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



