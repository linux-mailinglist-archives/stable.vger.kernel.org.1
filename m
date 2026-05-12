Return-Path: <stable+bounces-245417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CMwOMjcAmrJyAEAu9opvQ
	(envelope-from <stable+bounces-245417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:54:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A036451C419
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9805230089AE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1306147D949;
	Tue, 12 May 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="dVAUZeiw"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116C3FF88D;
	Tue, 12 May 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572484; cv=none; b=IFJqL4CKAoglASJwtVDDnO/XQ7XGXSNFnIrjpmuP6pnwPDyQef+qdBgWYPKFNwjHcr36gWz/3Vbjgwt/RzXg3MwcrIE+yELHxeDK3WlqVMjaS2b3ocMR7HKrQ3TJAyiG98DwBMXzShU1wiyYQNT3nhqxmg5F24/AXs94V1Sl1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572484; c=relaxed/simple;
	bh=YyPMJxhQLsVlPVe0LHeMiOciW0+rjA83duf3BFKhEqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIL9ZFfmlNwv+tQa9tmqfp/cpjK1uLpXcz0ChESyH14F5GmiWz3jt/tQlEMY4I90P/8cXpDX20yoP5PRL+XLLI24cemUbuOHVHySZ46GvaD57hJ6iQ/QP3NYmfdRSNzY4GbXniLfZ+JJzSNh97ysp8FyTlrtG3twU+99mRrrVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=dVAUZeiw; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dVAUZeiwfQkKS7Y8r/qQ1bRGGnHlg4I8FZDl+Mzq+4ATelP+n3HDJgLLHWLf2Ke5JgpMlEf+RYWP+
	 YzSDW1gUSc+EviPI6j1PzcL8MnsyZvKwXDMP0VxLlIpVDiVh1fRQSRyEZXTwrOPNViwI6dk27GoBvQ
	 1HAQnA8HmG5jNaUw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-139-kernel-team (unknown[183.241.54.211])
	by rmsmtp-lg-appmail-34-12048 (RichMail) with SMTP id 2f106a02dbb77b4-017d0;
	Tue, 12 May 2026 15:50:20 +0800 (CST)
X-RM-TRANSID:2f106a02dbb77b4-017d0
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	lanbincn@139.com,
	zhiguo.niu@unisoc.com,
	baocong.liu@unisoc.com,
	chao@kernel.org,
	jaegeuk@kernel.org,
	daehojeong@google.com
Subject: [PATCH 6.1.y 0/2] f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic
Date: Tue, 12 May 2026 15:50:08 +0800
Message-ID: <20260512075010.29584-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A036451C419
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,139.com,unisoc.com,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245417-lists,stable=lfdr.de];
	DMARC_NA(0.00)[139.com];
	DKIM_TRACE(0.00)[139.com:-];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.445];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

This series backports a fix, a use-after-free vulnerability
in the F2FS compressed file decompression path, to linux-6.1.y.

The fix stores the sbi pointer and compress_algorithm directly in the
dic struct at allocation time, eliminating the need to dereference the
inode during asynchronous cleanup.

Patch 1 is a preparatory cleanup that changes page_array_alloc/free to
take sbi as the first parameter instead of the inode.

Patch 2 is the actual UAF fix that adds sbi and compress_algorithm
fields to decompress_io_ctx and replaces all late inode dereferences.

Both patches apply cleanly to linux-6.1.170. No logic changes are
needed beyond replacing F2FS_I_SB(dic->inode) with dic->sbi for v6.1.

Testing:
  - Verified on a 6.1.170-yocto-standard kernel with F2FS compression
    enabled (lzo, lz4, zstd).
  - Ran stress tests exercising concurrent read+unlink races, multi-reader
    unlink, and forced inode eviction during deferred dic free.
  - All 15 test cases passed with no crashes or errors.

Zhiguo Niu (2):
  f2fs: compress: change the first parameter of page_array_{alloc,free}
    to sbi
  f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

 fs/f2fs/compress.c | 76 +++++++++++++++++++++++-----------------------
 fs/f2fs/f2fs.h     |  2 ++
 2 files changed, 40 insertions(+), 38 deletions(-)

-- 
2.43.0



