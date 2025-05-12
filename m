Return-Path: <stable+bounces-143135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B50AB321B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA86D188AFC3
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1F125A33C;
	Mon, 12 May 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT7Jwxxw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C025A327
	for <stable@vger.kernel.org>; Mon, 12 May 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039633; cv=none; b=WyUuJvXmhz6cvLwPQ74HKmKoyqtU/IETPJm30KwCkXAAW/Dd9nyKllqrBV/Gvf/xBZWiNVtI+nYNtA8J1NnrKTOKDRBhjPprR1kapqXqtrzIVo4aoHzxMMD8mPw05AolTB16GiHPfkB01GcO4lGagRVp+qiq/z5pqUrSyw5JqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039633; c=relaxed/simple;
	bh=C8UEs/WjcQ7neL89Xkok0PApjtPWCJob/S15QmVD2qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5nM4M1OeMXVdPrPCszC6IDfy5aMb+sxzDS1inJFrDbnrNiN5u+fkePE1QA51mdxxmM2NLyDNZRHWBvSJPXOmZSUhHF8azJ1hdbpnsWFHBh0XFS0Wc3uSXKUcsQ5Bx3+mb7QxXM3uvIhJ0CRfpBHFxelZe7+0Dx+YTzxPjldp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT7Jwxxw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747039629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49vTgJ1mdSo+qvl3pEP21wSc4TIuN6DSHhv70qZIbzs=;
	b=AT7Jwxxwe1Qf7Mt4liE+gvWF0o0IvNGq0pxtIdC4u940cXCmkXIksYd4oXi3OlTA8Ceb4f
	ykOqG79n6nmwTtByLSpxu+BjtCGguAlR00uIUHKzRhr9iCv73/tSDJ2VJsPA4VVw/CNmgw
	9+wntuTMynRH0zE80z/1jEON1rphaz0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-NmA2WMehNqKchbJZgXLdVw-1; Mon,
 12 May 2025 04:47:07 -0400
X-MC-Unique: NmA2WMehNqKchbJZgXLdVw-1
X-Mimecast-MFC-AGG-ID: NmA2WMehNqKchbJZgXLdVw_1747039626
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BAA4180056F;
	Mon, 12 May 2025 08:47:06 +0000 (UTC)
Received: from ebuild.redhat.com (unknown [10.44.33.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5771C30001AB;
	Mon, 12 May 2025 08:47:03 +0000 (UTC)
From: Eelco Chaudron <echaudro@redhat.com>
To: stable@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org
Subject: [PATCH 5.4.y] openvswitch: Fix unsafe attribute parsing in output_userspace()
Date: Mon, 12 May 2025 10:46:22 +0200
Message-ID: <b047b86872e58e15c3b8d3ba394fa1aef4b557ea.1747039582.git.echaudro@redhat.com>
In-Reply-To: <2025050913-rubble-confirm-99ee@gregkh>
References: <2025050913-rubble-confirm-99ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch replaces the manual Netlink attribute iteration in
output_userspace() with nla_for_each_nested(), which ensures that only
well-formed attributes are processed.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
Acked-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 6beb6835c1fbb3f676aebb51a5fee6b77fed9308)

---
The patch did not apply cleanly due to a previously applied style
fix that corrected indentation in the original for loop. This
patch has been adjusted accordingly to account for that change.
---
 net/openvswitch/actions.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 815a55fa7356..5af7fe6312cf 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -967,8 +967,7 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
 	upcall.cmd = OVS_PACKET_CMD_ACTION;
 	upcall.mru = OVS_CB(skb)->mru;
 
-	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
-		 a = nla_next(a, &rem)) {
+	nla_for_each_nested(a, attr, rem) {
 		switch (nla_type(a)) {
 		case OVS_USERSPACE_ATTR_USERDATA:
 			upcall.userdata = a;
-- 
2.47.1


