Return-Path: <stable+bounces-245384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P8NFaaUAmqJugEAu9opvQ
	(envelope-from <stable+bounces-245384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:47:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BDE519064
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3574303309C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCFD363081;
	Tue, 12 May 2026 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QAbQsW44"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927E373BF4
	for <stable@vger.kernel.org>; Tue, 12 May 2026 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553993; cv=none; b=H69w2cbHW0QN/BGi8Dg5q4JHxiL8Q5+bBOQV6cuZnZrPKpBXB97zCIp8U2udlozotaKRqHUVZIlELRRmqpe9A5vYzIiVNcWTXIBnMDIU+1+xZl7BUNY4l9EyZ2K/krvzpivFEA7yD4LFf3rdANLW1f/y1n8DLclHBBwQHWkre4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553993; c=relaxed/simple;
	bh=07Q08ExYcyQESjc/PqxPrbU68auY5egY6BIY12Wz1I0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zs3lU7rLH2z1VivmshILrMQpv81w7gAmb+OstSLqbWPYHOK1eCT4F0Pupjg/Giur0fnjVUyAZPcZEyXZVj8qfE9f/SPBH43R0ywGX3kVjf0je5UiS5bLySAQSuqL0HML3+HOtP+ncKdOqklQE6WfU3oi7Xo3e1ZVOaGzEkb1h44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QAbQsW44; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778553988; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bD03Inlr+dQtA8KG5gaMFNQNUval7POvlgFnW8fMJTc=;
	b=QAbQsW44ddvBA4D6lEzBLPCE5O03mXkYmDS4XetJSXMnD1i5TShrpxuCw9y8wvp2hj0EGhaq6YbHQHX9ae/QhmFJ806b1XXOLaJ+5kW1xVW0ZvbzPEXTCRDAg1q6igovQKv1zsm4VRG22Wuki4Irb9F189iP1zCzrsP2RMgrcAs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X2ooQxH_1778553984;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0X2ooQxH_1778553984 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 10:46:28 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 0/2] ksmbd: fix residual active_num_conn leak on 6.1.y
Date: Tue, 12 May 2026 10:46:22 +0800
Message-Id: <cover.1778553684.git.mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3BDE519064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245384-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[mengferry@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series closes a residual active_num_conn leak on the 6.1.y stable

Upstream commits 77ffbcac4e56 ("smb: server: fix leak of active_num_conn
in ksmbd_tcp_new_connection()") and 6551300dc452 ("smb: server: fix
active_num_conn leak on transport allocation failure") have already been
backported to 6.1.y, but upstream 77ffbcac4e56 was built on top of
5da92a251e41 ("ksmbd: make ksmbd thread names distinct by client IP"),
which removes kernel_getpeername() and the out_error: label in
ksmbd_tcp_new_connection().

This series picks up the missing dependency commit and the follow-up fix
so that 6.1.y has the same failure-path semantics as mainline.

Michael Bommarito (1):
  smb: server: fix active_num_conn leak on transport allocation failure

Namjae Jeon (1):
  ksmbd: make ksmbd thread names distinct by client IP

 fs/smb/server/transport_tcp.c | 41 +++++++++++++----------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

-- 
2.43.5


