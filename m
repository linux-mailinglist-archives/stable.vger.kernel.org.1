Return-Path: <stable+bounces-224715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iER8JWiWsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:20:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0121F2673AA
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 855DF300BC95
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D603E1D08;
	Wed, 11 Mar 2026 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="ROiWVa14"
X-Original-To: stable@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BD337688
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246023; cv=none; b=g5vX/VfPelzUnefWa3zfIwYfKRg/tY6sKOINhcRyhkzFpIoMazJ4m23Mo6Q3Ma16mK7kiE4EJRXspaEmt1u4iHjT4FKxqd0FdY3sJiazjAO5AMRYFzij+mp0h28/4r+LdjBronmPlIBZfsyE3jWWao+/QYFCGvGCbP5nplh5K6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246023; c=relaxed/simple;
	bh=yfmmkwAeJvWfGL49tAgU1v5Tud7TSPPe/MHUoUFfoV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY7czA7pmVXlOqLfas2ytAMyjAajYylgkGQWfKY23ka/s1NqdjBvCi+HHS4+lHaW+TPQaU5QSuAD53ZvuVQxTzx3AIDz1rDnQLSaAVIFjPNILp5EEJ/D+Abrr+FsRO12v12Vy8K9n5ZQc7YtwPfwpWU0k/IuWvwhCPYW2+sh7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=ROiWVa14; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
From: Eric Hagberg <ehagberg@janestreet.com>
To: sashal@kernel.org
Cc: patches@lists.linux.dev,
 	stable@vger.kernel.org,
 	peterz@infradead.org,
 	kprateek.nayak@amd.com,
 	shubhang@os.amperecomputing.com,
 	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH 6.18 022/314] sched/fair: Fix zero_vruntime tracking
Date: Wed, 11 Mar 2026 12:14:00 -0400
Message-ID: <20260311161400.1003322-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <05467440d95c78161254bab895be5692e4f0a3f3.1773141555.git.sashal@kernel.org>
References: <05467440d95c78161254bab895be5692e4f0a3f3.1773141555.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1773245700;
  bh=yfmmkwAeJvWfGL49tAgU1v5Tud7TSPPe/MHUoUFfoV4=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=ROiWVa14wvindocmtMe/Scfo1SCMTDmkdOJIe0Gi3eRDcwVy9Cv9bNQCah/X2ya5a
  ELyP5Rylg/hvvy3T3gz55+MdM4MAfbt+VxjlPfkTK1ecSHvKGBuvCWKMCdKKLWnyDT
  u8r19WVDg18J3TsbUNVRhiW+i2UYcovNNzUzwd+WgXRGZK+ncDPX98fa0q3jbq54va
  3M5Je31/TtEBgB0G4DoSAJPJBLUyVV/Q6v9nUwjkhPhgtXmUKY6BT0Z8EOyKBLZSDc
  4ORcBW0F43cI6BkL3QIAhdJrOmtXBOilNRxl1rY62yKC2c7WDTECTRJOpJYs4XAKcn
  fTGvWc2b7rNhg==
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[janestreet.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[janestreet.com:s=waixah];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224715-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[janestreet.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ehagberg@janestreet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,janestreet.com:dkim,janestreet.com:mid]
X-Rspamd-Queue-Id: 0121F2673AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Shouldn't this also be applied to the 6.12 stable kernel as well, since it has the patch
mentioned in the Fixes: line?

The broken tracking mentioned in the test case is seen in 6.12 kernels as well.

