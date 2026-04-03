Return-Path: <stable+bounces-233235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKRGIi0j0Gkp3wYAu9opvQ
	(envelope-from <stable+bounces-233235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 22:29:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 832AF3982CC
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 22:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41986301DA5E
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0D3D811F;
	Fri,  3 Apr 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="kOolXopk"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC7303C9C;
	Fri,  3 Apr 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248146; cv=none; b=caibZ9/HS4Gf3vfHsCt62Z3eGnS6/KXt3+B1kqst+f8JZcKQWP3g91T+kVEZw0Cymb86ViiWnw5rbkODCcjfnzRDapmcF6dhXsj+e4npa76gV6ssco4LnYCm3Q0PjHxkG4L5leYT6jJpH2x0c62KtaPH8q691NE2M08wfBmRDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248146; c=relaxed/simple;
	bh=3unORSCN4s2sh8aP3asXtDv5qrrMJJ2xu+YUzP+1EUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgK0BVPLszctDc1UDDreVveVCiVa7LUHNrXFZTO//i9f8jJNHE5jSSorBQyn4zGvhUc0mCIk4WLaTeZiww9Rmh+xSjgujA9mhGOWjM7ZNJZEeqxZ0WVNEKesSckVAATgnzzG4J+pAbWTJJ5EC19prEJKn2iGADudd9AtornXtzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=kOolXopk; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.lan (unknown [79.139.252.175])
	by mail.ispras.ru (Postfix) with ESMTPSA id CB3C045A1D06;
	Fri,  3 Apr 2026 20:29:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CB3C045A1D06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775248142;
	bh=rkMgPId7pYnnvNbAuwYM5wExpHWHyYhMeO7FUfW2+ho=;
	h=From:To:Cc:Subject:Date:From;
	b=kOolXopkJtnCfd+9m8RNpBDmXydllXw3oykDCDNbEpSHP0DisAbGRJiGpW3FTRp6p
	 0dkuNbDhU9KFyGKb4JdvMVGzHOOgLGFHuABWqABZOiVj6x0yAlJKaigNotN5Es24jh
	 j9xqoW7gspk2ovsJBViM+PvF5ADZlvItRSQhTTgs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Heyne, Maximilian" <mheyne@amazon.de>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] nvme-apple: drop invalid put of admin queue reference count
Date: Fri,  3 Apr 2026 23:27:00 +0300
Message-ID: <20260403202701.991276-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233235-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ispras.ru:dkim,ispras.ru:email,ispras.ru:mid,linuxtesting.org:url]
X-Rspamd-Queue-Id: 832AF3982CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 03b3bcd319b3 ("nvme: fix admin request_queue lifetime") moved the
admin queue reference ->put call into nvme_free_ctrl() - a controller
device release callback performed for every nvme driver doing
nvme_init_ctrl().

nvme-apple sets refcount of the admin queue to 1 at allocation during the
probe function and then puts it twice now:

nvme_free_ctrl()
  blk_put_queue(ctrl->admin_q) // #1
  ->free_ctrl()
    apple_nvme_free_ctrl()
      blk_put_queue(anv->ctrl.admin_q) // #2

Note that there is a commit 941f7298c70c ("nvme-apple: remove an extra
queue reference") which intended to drop having an extra admin queue
reference.  Looks like at that moment it accidentally fixed a refcount
leak, which existed since the driver's introduction.  There were an
initial ->set and an extra ->get call at driver's probe function, and only
a single ->put inside apple_nvme_free_ctrl().

However now after commit 03b3bcd319b3 ("nvme: fix admin request_queue
lifetime") the refcount is imbalanced again.  Fix it by removing extra
->put call from apple_nvme_free_ctrl().  Compile tested only.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime")
Cc: stable@vger.kernel.org # depends on 941f7298c70c
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Also nvme-apple seems not to have a blk_mq_destroy_queue() call for
admin queue since introduction - if it's needed, the proper place would
be in apple_nvme_remove() just before calling nvme_uninit_ctrl(), I guess?

 drivers/nvme/host/apple.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..1d82f0541b0b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1269,8 +1269,6 @@ static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct apple_nvme *anv = ctrl_to_apple_nvme(ctrl);
 
-	if (anv->ctrl.admin_q)
-		blk_put_queue(anv->ctrl.admin_q);
 	put_device(anv->dev);
 }
 
-- 
2.53.0


