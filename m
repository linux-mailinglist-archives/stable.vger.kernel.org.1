Return-Path: <stable+bounces-89905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FAA9BD351
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9DF1C2270E
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D441E1308;
	Tue,  5 Nov 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsKd7h9D"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7F1D90B4
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827562; cv=none; b=Y37dwL3/roEKSJhl50345H6AlfADEDhU3Pu5J84r68DEgouzy5jC/Wwz1Zemetd3JBlihewk5Tn2jYfysx5TLrs3Rhf2hAtLZ1Ef1azicyIk0EPsO/ChojSHg5+uzi6rCWbtkB7YuX+tUf1v72UDXV2UJhpN2+h7B3Fljxw21N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827562; c=relaxed/simple;
	bh=9CRlXKzX/vXmQpdQmYuu7NvoZFG+CP3Ic5QDcOzwx4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9P29qeiRl9tecHC0h5RY2JY9hMR/MjAL9EvXG6NSkIc41R8u4zCtPqDsnLNATaoHR8J3gsvqVIXV1Zi+p7vf+oY6qpnslCWEMsdZr6dbE8wxO7/UxIErRjbmBJ5SN8L05hGr812r4FNablo9u/F3Hr7ugMWO9AJ4he/huE8o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsKd7h9D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730827559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ToefbGyR/yma5VyAmpuseCaNgrfSwuPwtORvozSJZs4=;
	b=KsKd7h9DaJ0Aw8cJoRdlnCwLQMITctvgzzo2sLMNihFdu5N4MRYesPIq4wezzvEQjK+h4u
	yvVXLVhe4eMbXK2t3wiuQvkr2L9zerdFKvgimN+kNTnWYQyJ3ySYtzRypqjbCGHuzV6j5E
	KFBDLaITeHTRqFWuAVNnw1wQKE6Eh/c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-cQyeVpHaOYyXv_jDHa88jA-1; Tue,
 05 Nov 2024 12:25:57 -0500
X-MC-Unique: cQyeVpHaOYyXv_jDHa88jA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FB551955F33;
	Tue,  5 Nov 2024 17:25:55 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.88.242])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69C5D19560AA;
	Tue,  5 Nov 2024 17:25:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 6.6.y 0/2] mm: don't install PMD mappings when THPs are disabled by the hw/process/vma
Date: Tue,  5 Nov 2024 18:25:48 +0100
Message-ID: <20241105172550.969951-1-david@redhat.com>
In-Reply-To: <2024101842-empty-espresso-c8a3@gregkh>
References: <2024101842-empty-espresso-c8a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Resending both patches in one series now, easier for everybody that way.

Conflicts:
* "mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()"
 -> The change in mm/shmem.c does not exist yet.
 -> Small contextual conflict.
* "mm: don't install PMD mappings when THPs are disabled by the hw/process/vma"
 -> Small contextual conflict.

v1 -> v2:
* "mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()"
 -> Keep using "return false;" instead of "return 0;"

David Hildenbrand (1):
  mm: don't install PMD mappings when THPs are disabled by the
    hw/process/vma

Kefeng Wang (1):
  mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()

 include/linux/huge_mm.h | 18 ++++++++++++++++++
 mm/huge_memory.c        | 13 +------------
 mm/memory.c             |  9 +++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.47.0


