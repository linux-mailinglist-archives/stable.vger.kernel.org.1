Return-Path: <stable+bounces-41856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF68B7009
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9E11C2190A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465F12C46C;
	Tue, 30 Apr 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQKEYLaW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722812BF21;
	Tue, 30 Apr 2024 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473766; cv=none; b=elVQfy0jCyutJ2A1p4df4YIm3iDccbQ0qMgp7tEwALKKWC9r3yyDKurYFoyGE5dypCHB7YrljZOqDUmEx8UI17RB5s6fJxVzuE3vKs5Vj4pe8JuZ1+lfsgUeKb2m6eI0Bve8iH72fxSSSu4kTDb85VjKKtN9RaAyZi7rpLxnlww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473766; c=relaxed/simple;
	bh=xDfJOzT6eSeA6UcH2PcaUtAYMM2iaezGcR0HlLQOdPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCCEAldcHyXHNNdvV24NncDPyNB1XY0yrl3oqNxXCms5FZ70dluVUjQDODEHTZF+UbZO/Yu0fNMfhFWDvKVT6c/XtHhNcF+yp7dZY6mW2Bxyw8y2Pyo06SRHknRiornzthwsHBUUBrorsXcVga4uPqGcyXCjOis2kL5t/v6tilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQKEYLaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60231C2BBFC;
	Tue, 30 Apr 2024 10:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714473766;
	bh=xDfJOzT6eSeA6UcH2PcaUtAYMM2iaezGcR0HlLQOdPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQKEYLaWxoxRpgpIAUHlWlD540n2MVjWVeNFHAHJO5b9KKrZoFgDGM67s2EmZSly3
	 Cd5W2LFqqCAy/kGK4PAp+nIbsYDHRT9SF6GEtJ2eInsveZUBiomz1K13k3nurDAt1b
	 lyVv/YcXcEgdeELZmKa053fw8bLNECYuBJcRsnww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 4.19 32/77] speakup: Avoid crash on very long word
Date: Tue, 30 Apr 2024 12:39:11 +0200
Message-ID: <20240430103042.079698881@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
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

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

commit c8d2f34ea96ea3bce6ba2535f867f0d4ee3b22e1 upstream.

In case a console is set up really large and contains a really long word
(> 256 characters), we have to stop before the length of the word buffer.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Fixes: c6e3fd22cd538 ("Staging: add speakup to the staging directory")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240323164843.1426997-1-samuel.thibault@ens-lyon.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/speakup/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -577,7 +577,7 @@ static u_long get_word(struct vc_data *v
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);



