Return-Path: <stable+bounces-26892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B7872BF5
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 02:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49D51F24362
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D463D9;
	Wed,  6 Mar 2024 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRYtzf92"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EDC4C91
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687290; cv=none; b=kNp9F1UVq/jZqXwrMcVpxrHxHDWhWI7t5r68UHVM0t8a5i3E+c1v/rQfSH25VZ541x65YgG7FAAIEEp2Xln5HOQ45b68lE0e0/U9KFNAPw45dCF8RBMwttTm+nkxPvUiPM2m1RE1FT9gzvaCGGFRsNrwC12/ijlbBwKJOHbgmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687290; c=relaxed/simple;
	bh=SsmH7y7phE3+6HRd1ag269qvwQMP8NQvOUrkGiQ2yWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPLuGuRfaXGbrJsWq1WxWrJiMAaEmdhdcl797joMR4yPgiJfPvjtj4mlmb/NhaRDG7VAWKMYkyJZX7xh8QtaKZwBCxLKJHdpxRcVVcYm8l9VFbR0CwqHy/4+kahlPoYkLy9SxOjVJuPrEqepSH3UA+DJaEYtZtm9haUwNmxqwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRYtzf92; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709687288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4J6XVV139H2p+jUWQqRDSu5CtocuL0hjR/mC6mRpU1A=;
	b=IRYtzf92xCqx4iTCyulS4fBJm+Qpy4cN/XlbBN/JQK26Ar1y5nkmzzFYLd2wQfKPIJbIGd
	MdW+15THZMLqQF/W8u5Lh/M/hhq8kdx+hrMUXhNKPyJEAlv5bAn4CpkJWkye4x2us7S4sy
	ScVH/pLxOLQM437hZMnfA8Ayxs5aoI0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-sSyz-_hsMe6ZPxEx4RCtBw-1; Tue, 05 Mar 2024 20:08:05 -0500
X-MC-Unique: sSyz-_hsMe6ZPxEx4RCtBw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91FE48007B0;
	Wed,  6 Mar 2024 01:08:04 +0000 (UTC)
Received: from li-a71a4dcc-35d1-11b2-a85c-951838863c8d.ibm.com.com (unknown [10.72.112.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8163C492BE8;
	Wed,  6 Mar 2024 01:08:00 +0000 (UTC)
From: xiubli@redhat.com
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	jlayton@kernel.org,
	vshankar@redhat.com,
	mchangir@redhat.com,
	Xiubo Li <xiubli@redhat.com>,
	stable@vger.kernel.org,
	Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v2] libceph: init the cursor when preparing the sparse read
Date: Wed,  6 Mar 2024 09:05:44 +0800
Message-ID: <20240306010544.182527-1-xiubli@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Xiubo Li <xiubli@redhat.com>

The osd code has remove cursor initilizing code and this will make
the sparse read state into a infinite loop. We should initialize
the cursor just before each sparse-read in messnger v2.

Cc: stable@vger.kernel.org
URL: https://tracker.ceph.com/issues/64607
Fixes: 8e46a2d068c9 ("libceph: just wait for more data to be available on the socket")
Reported-by: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---

V2:
- Just removed the unnecessary 'sparse_read_total' check.


 net/ceph/messenger_v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index a0ca5414b333..ab3ab130a911 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2034,6 +2034,9 @@ static int prepare_sparse_read_data(struct ceph_connection *con)
 	if (!con_secure(con))
 		con->in_data_crc = -1;
 
+	ceph_msg_data_cursor_init(&con->v2.in_cursor, con->in_msg,
+				  con->in_msg->sparse_read_total);
+
 	reset_in_kvecs(con);
 	con->v2.in_state = IN_S_PREPARE_SPARSE_DATA_CONT;
 	con->v2.data_len_remain = data_len(msg);
-- 
2.43.0


