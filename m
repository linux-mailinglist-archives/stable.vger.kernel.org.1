Return-Path: <stable+bounces-224177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA0SKbT9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF8624A4AC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B76D30039A8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8636896F;
	Tue, 10 Mar 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="PvRdeXcM"
X-Original-To: stable@vger.kernel.org
Received: from smtp120.iad3b.emailsrvr.com (smtp120.iad3b.emailsrvr.com [146.20.161.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD73372B31
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141420; cv=none; b=HNAlEFWVXR8sbTaM7jhFroiLjFveEMvb/QxKoUsuhyBzA6gftEuE2YVpfclYqU/hWSeSFnRGo/AZB+AJ72uzAGAeeX5GAm1CITADI+406188lVl3U0ZCygMicpprRgwsrf6fPruNGtVLORxqBgJdelOrEr6TcwNi/cyaHJRNn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141420; c=relaxed/simple;
	bh=aE92pupaNgfpAcjrWGvfnpRHer38DfIUodQwoHnlewg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7CrTVXJhGTvu0LdmKGgfTpVViUM24+qn01jOwGV4QotlGbe6+pC7mBIdVlZAwXQO44713R+nvTvohnEYrmJBgRPcZi1TB/qGkCXs52CL9shflHeX0liT0jb7uwwAkfMwBlhRjK7054xSZZCHKh1K3/237F1fLQeaw1k2Ir7PuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=PvRdeXcM; arc=none smtp.client-ip=146.20.161.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1773141082;
	bh=aE92pupaNgfpAcjrWGvfnpRHer38DfIUodQwoHnlewg=;
	h=From:To:Subject:Date:From;
	b=PvRdeXcMzfhRlvemu5mdRQ1o2KCPTih0MqycnkZ7ZWQQpm1lORX4KnXQxO1a5LUQw
	 P9EaMEACQnGTCOcAKnFRTVmrFTi1qPGd3PhYx1hoBJKEq3L5BfUu+qr87sQJUWoZhN
	 ode+1opA9CwUrRkldJ/mdnhdTpPMojyYUmZ3on0o=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 35607401B6;
	Tue, 10 Mar 2026 07:11:21 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+f238baf6ded841b5a82e@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] comedi: runflags cannot determine whether to reclaim chanlist
Date: Tue, 10 Mar 2026 11:11:04 +0000
Message-ID: <20260310111104.70959-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 8eb0b720-eb0d-425d-b263-4f6452de4f67-1-1
X-Rspamd-Queue-Id: 4AF8624A4AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mev.co.uk,none];
	R_DKIM_ALLOW(-0.20)[mev.co.uk:s=20221208-6x11dpa4];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,mev.co.uk,visionengravers.com,qq.com,syzkaller.appspotmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224177-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abbotti@mev.co.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mev.co.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,f238baf6ded841b5a82e];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

From: Edward Adam Davis <eadavis@qq.com>

syzbot reported a memory leak [1], because commit 4e1da516debb ("comedi:
Add reference counting for Comedi command handling") did not consider
the exceptional exit case in do_cmd_ioctl() where runflags is not set.
This caused chanlist not to be properly freed by do_become_nonbusy(),
as it only frees chanlist when runflags is correctly set.

Added a check in do_become_nonbusy() for the case where runflags is not
set, to properly free the chanlist memory.

[1]
BUG: memory leak
  backtrace (crc 844a0efa):
    __comedi_get_user_chanlist drivers/comedi/comedi_fops.c:1815 [inline]
    do_cmd_ioctl.part.0+0x112/0x350 drivers/comedi/comedi_fops.c:1890
    do_cmd_ioctl drivers/comedi/comedi_fops.c:1858 [inline]

Fixes: 4e1da516debb ("comedi: Add reference counting for Comedi command handling")
Reported-by: syzbot+f238baf6ded841b5a82e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f238baf6ded841b5a82e
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Cc: <stable@vger.kernel.org> # 6.19+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/comedi_fops.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index b91e0b5ac394..c09bbe04be6c 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -793,13 +793,15 @@ static void do_become_nonbusy(struct comedi_device *dev,
 	__comedi_clear_subdevice_runflags(s, COMEDI_SRF_RUNNING |
 					     COMEDI_SRF_BUSY);
 	spin_unlock_irqrestore(&s->spin_lock, flags);
-	if (comedi_is_runflags_busy(runflags)) {
+	if (async) {
 		/*
 		 * "Run active" counter was set to 1 when setting up the
 		 * command.  Decrement it and wait for it to become 0.
 		 */
-		comedi_put_is_subdevice_running(s);
-		wait_for_completion(&async->run_complete);
+		if (comedi_is_runflags_busy(runflags)) {
+			comedi_put_is_subdevice_running(s);
+			wait_for_completion(&async->run_complete);
+		}
 		comedi_buf_reset(s);
 		async->inttrig = NULL;
 		kfree(async->cmd.chanlist);
-- 
2.51.0


