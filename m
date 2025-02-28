Return-Path: <stable+bounces-119944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99638A49B1E
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614B93B8DD4
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9725F984;
	Fri, 28 Feb 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8MBqYoY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63051B960
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751069; cv=none; b=ftazz7o5xG1uoSXGCKY5XdxGMrUag0megcsH0QscK5/qHd2n6WRVd7nFPfLJDUBTUcZjXqjFBL0LRJVn1lNS0HNkX/EDSgF4Gdw7NXtZoDlP9Ve6z70jYgPVWe1l8I+2Wja2oGdDv50LisDIw6iXV0fSgkeOsbgWgLHBHHbgEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751069; c=relaxed/simple;
	bh=LmNnymyDRMQh4zasSfmMJnhxrSfT7w2H8cpGYZPItIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SokJqvIs/OP0fkrj0PIDZ9gb2Y7YkPhMtJiCTgXe8nnFX/HFnItTvvFSVCsELONoLPORThxukG7V7WDEH5gT6ZgsYXt8Nv/WvkvWAYKi/WWH1CpHNOciYuk9iLS5kuvJhJ43N+Pm06VKDeix8oRzrVGqiXXdENd/V2k7OD2jw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8MBqYoY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740751066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4tJMWLxEOmnDMKsq1iIlmNSVPW5kIHv+PP2iRLcLY4k=;
	b=P8MBqYoYpX84LegTcYXC0JlMG1Es8Mvi9D85ZSO9VItN4f4GgApEnITpZTcmUvJFjcDhde
	w7FoKHca/zuV58cNQigZNGL4t+RlZr+i+EIRb/rrkzpznDAG5TQDSpiSsp4/kG9WyMhwn6
	AJOss/XEHzfKXsFI03F8luNNfZRYIRw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-NbygKyI6PLy0EGZZWap__Q-1; Fri,
 28 Feb 2025 08:57:43 -0500
X-MC-Unique: NbygKyI6PLy0EGZZWap__Q-1
X-Mimecast-MFC-AGG-ID: NbygKyI6PLy0EGZZWap__Q_1740751062
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C2991955BFC;
	Fri, 28 Feb 2025 13:57:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA3A51800358;
	Fri, 28 Feb 2025 13:57:37 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wang Yugui <wangyugui@e16-tech.com>,
	Jan Kundrat <jan.kundrat@cesnet.cz>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6.6 0/4] rtla/timerlat: Fix "Set OSNOISE_WORKLOAD for kernel threads"
Date: Fri, 28 Feb 2025 14:57:04 +0100
Message-ID: <20250228135708.604410-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Two rtla commits that fix a bug in setting OSNOISE_WORKLOAD (see
the patches for details) were improperly backported to 6.6-stable,
referencing non-existent field params->kernel_workload.

Revert the broken backports and backport this properly, using
!params->user_hist and !params->user_top instead of the non-existent
params->user_workload.

The patchset was tested to build and fix the bug.

Tomas Glozar (4):
  Revert "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads"
  Revert "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads"
  rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
  rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads

 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 tools/tracing/rtla/src/timerlat_top.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.48.1


