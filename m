Return-Path: <stable+bounces-34797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D9F8940E3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7626DB20B68
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD011E525;
	Mon,  1 Apr 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XmCY1r+H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AC1C0DE7;
	Mon,  1 Apr 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989329; cv=none; b=PQNHxHmSfTf0Em99ND7rY0WcrqNWT7RL/rG32XTH/LFMMDhMzXAxZniJOrgcReS8UYX/iXSS7+Rt5IqRpyMhFcVLPE1wwmcBkNwL0R7kNbAyXgkDjNH9C8ynAXQNd++UfZcEHgmlTMiBe6wvvsHcgtfMMTuX89O0u6xUsa+vYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989329; c=relaxed/simple;
	bh=28c5/dQctOewvr7eKy5ys2X81MAovbuGscWP6+OQWkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6XqyAifHrGYiO+mBhwaI6in/JZ5qTlRFt/y6NMUapMmE+heAOVnDhFbWcxCzcp6WE6/KkbrbwhAEVhFz9xxQVNydFGnUIsVEcbQArd7oTj7SbEiGXDmAl+ghD+LjxNSE8sCq1BfdruDbWwLxjF2Snm1FevGmO7vd2kEv1QrjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XmCY1r+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0A0C433C7;
	Mon,  1 Apr 2024 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989329;
	bh=28c5/dQctOewvr7eKy5ys2X81MAovbuGscWP6+OQWkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmCY1r+H59iQwE3j/UWLfUSkDgR4BSeY/ePGTdPJRANiI3kCiQlyGSkG+e8i1nFtx
	 6lNkYfi3v7/zOFt1rIS4fC3wszvIk8tXymUTHsJYoR0qD5gLsL5ugNvtajtaOWQMht
	 NQJ+S+M9HdtBdMdMv3MrBIIV8dx1g7l/eKGZZ9CI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	BassCheck <bass@buaa.edu.cn>,
	Gui-Dong Han <2045gemini@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 017/396] media: xc4000: Fix atomicity violation in xc4000_get_frequency
Date: Mon,  1 Apr 2024 17:41:06 +0200
Message-ID: <20240401152548.407841442@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gui-Dong Han <2045gemini@gmail.com>

[ Upstream commit 36d503ad547d1c75758a6fcdbec2806f1b6aeb41 ]

In xc4000_get_frequency():
	*freq = priv->freq_hz + priv->freq_offset;
The code accesses priv->freq_hz and priv->freq_offset without holding any
lock.

In xc4000_set_params():
	// Code that updates priv->freq_hz and priv->freq_offset
	...

xc4000_get_frequency() and xc4000_set_params() may execute concurrently,
risking inconsistent reads of priv->freq_hz and priv->freq_offset. Since
these related data may update during reading, it can result in incorrect
frequency calculation, leading to atomicity violations.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 6.2.

To address this issue, it is proposed to add a mutex lock pair in
xc4000_get_frequency() to ensure atomicity. With this patch applied, our
tool no longer reports the possible bug, with the kernel configuration
allyesconfig for x86_64. Due to the lack of associated hardware, we cannot
test the patch in runtime testing, and just verify it according to the
code logic.

[1] https://sites.google.com/view/basscheck/

Fixes: 4c07e32884ab ("[media] xc4000: Fix get_frequency()")
Cc: stable@vger.kernel.org
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/tuners/xc4000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index 57ded9ff3f043..29bc63021c5aa 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -1515,10 +1515,10 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 {
 	struct xc4000_priv *priv = fe->tuner_priv;
 
+	mutex_lock(&priv->lock);
 	*freq = priv->freq_hz + priv->freq_offset;
 
 	if (debug) {
-		mutex_lock(&priv->lock);
 		if ((priv->cur_fw.type
 		     & (BASE | FM | DTV6 | DTV7 | DTV78 | DTV8)) == BASE) {
 			u16	snr = 0;
@@ -1529,8 +1529,8 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 				return 0;
 			}
 		}
-		mutex_unlock(&priv->lock);
 	}
+	mutex_unlock(&priv->lock);
 
 	dprintk(1, "%s()\n", __func__);
 
-- 
2.43.0




