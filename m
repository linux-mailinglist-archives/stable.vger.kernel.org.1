Return-Path: <stable+bounces-98972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9069E6B53
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877291884AA7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB31B0F1D;
	Fri,  6 Dec 2024 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUVk59rj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23028684
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479746; cv=none; b=SLwU/uUZYKn1RfR7KBMk02UXLXwgQGDkyGy/8Lxvjx66J8/IUdCEIEV9kyjbA3AMOu4RUJSfo4qUCrm4Fc34jIYm4d/la+HAKZPDEjtO4+7414jYqignjdCcMTJrW/fpMnqR5uIPPVb0hGtCPmG2M8vtDlRGchl1WrR4bh1Q4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479746; c=relaxed/simple;
	bh=u0o1+kUFJXJPwycF7JVxT8TRn0GsSyRFS002kiOyao8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OCl3tmOfPtyv4uTGXI3iacMVK3pISqphio0GnpB4toR7Z8g8E+N0gHpBNpDve4/fF7+f87T+iUpbCoWdtHgtm8622FqfTY43tLebAW8UityxA6p46+DxhcS4g+gOjMN+iVM0l//TbH4hR0kHpFZWahR0bo40S33W1fCCC3vMo7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUVk59rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7C9C4CED1;
	Fri,  6 Dec 2024 10:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733479745;
	bh=u0o1+kUFJXJPwycF7JVxT8TRn0GsSyRFS002kiOyao8=;
	h=Subject:To:Cc:From:Date:From;
	b=pUVk59rjXsZSnvM+yzMQ1GZoKJlJyVzHCWekQ4sgm5s/lq3IiAuKLPr3t6ne2ObNB
	 iPfOmRN0usjCwVNKJA/tiG0lq/y7NM32mSGWebuP8aj97nfJhRVNO1h8rE4ys4KGHZ
	 q1BwtQx8BwkkQdlhkhcSRZIxVrYsUXZRihTbo8ZE=
Subject: FAILED: patch "[PATCH] media: dvb-core: add missing buffer index check" failed to apply to 6.12-stable tree
To: hverkuil-cisco@xs4all.nl,benjamin.gaignard@collabora.com,chenyuan0y@gmail.com,mchehab+huawei@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:09:02 +0100
Message-ID: <2024120601-unheard-margarine-05ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bfe703ac0c9f42fd54ec46416146f46d9502bc8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120601-unheard-margarine-05ff@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bfe703ac0c9f42fd54ec46416146f46d9502bc8c Mon Sep 17 00:00:00 2001
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Tue, 1 Oct 2024 11:01:34 +0200
Subject: [PATCH] media: dvb-core: add missing buffer index check

dvb_vb2_expbuf() didn't check if the given buffer index was
for a valid buffer. Add this check.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 7dc866df4012 ("media: dvb-core: Use vb2_get_buffer() instead of directly access to buffers array")
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
index 192a8230c4aa..29edaaff7a5c 100644
--- a/drivers/media/dvb-core/dvb_vb2.c
+++ b/drivers/media/dvb-core/dvb_vb2.c
@@ -366,9 +366,15 @@ int dvb_vb2_querybuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
 int dvb_vb2_expbuf(struct dvb_vb2_ctx *ctx, struct dmx_exportbuffer *exp)
 {
 	struct vb2_queue *q = &ctx->vb_q;
+	struct vb2_buffer *vb2 = vb2_get_buffer(q, exp->index);
 	int ret;
 
-	ret = vb2_core_expbuf(&ctx->vb_q, &exp->fd, q->type, q->bufs[exp->index],
+	if (!vb2) {
+		dprintk(1, "[%s] invalid buffer index\n", ctx->name);
+		return -EINVAL;
+	}
+
+	ret = vb2_core_expbuf(&ctx->vb_q, &exp->fd, q->type, vb2,
 			      0, exp->flags);
 	if (ret) {
 		dprintk(1, "[%s] index=%d errno=%d\n", ctx->name,


