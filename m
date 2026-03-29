Return-Path: <stable+bounces-230879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI7+MDsKyWm5tgUAu9opvQ
	(envelope-from <stable+bounces-230879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:17:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7490B351C24
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99BD03005AA9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93135AC3E;
	Sun, 29 Mar 2026 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="vZ79p8O0"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host1-snip4-10.eps.apple.com [57.103.65.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5235AC0D
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783033; cv=none; b=OAfkH/2h4SBENedfeTz6p1zkPiJAl1RiUq9YCLAPjkDU/vMwxbaN0rvGHlFZl8ZuW6d5YYUxY2O0nGW8aFRWiLLp8yv2lnro2edjap/h2ZeHT4wUJRoBkAAeJ8XVZzAV7MDw4HNyYOLKeeknO7jgF3gk0VNHeT3r7u7f76ynF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783033; c=relaxed/simple;
	bh=HDqBz5WEHQfMLl4Nx5oP0XhP8PxMU+MNQ7aQoI83584=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riUKCIS2LBJlh5PtIRkTztPBRQESSUNXNJb0dFLWsf7jXkHW/eccgSBIoUmCYa2I+Sb+yQIebizhPeXuSnQQYl215CDosQkF3WN/pobT7juLdB3WZYM9UfUpP//lUtr4doEaddxVGyN2s3ZOugEKS2PQsAD1OqWTBJSap0pYojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=vZ79p8O0; arc=none smtp.client-ip=57.103.65.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPS id 7461C180012F;
	Sun, 29 Mar 2026 11:17:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1774783031; x=1777375031; bh=P8jZfeKvtyoU7sMll426NVb+Ub63B74ie8+hAMe8W8o=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=vZ79p8O0NIuFlKrxIMzcayd46eJLRgRAErvf/czpLiKN/2FztZlrdGHVht2R1MmUYJqC/3TxsQ2d3cx7qzJ5eyEiv/qB7D+q0fpxgZxROWJe4dszG6r70vZQa15YAOcCI1lwdKa5QDSVhVgm+0YKcJ00DgQfzfjC+BTk+GlkA730at3cxQplGMqad/5kn5A9JyizCnUF34tlnOuw7z7Augd54Vnc3XYB9fMaCJSExw2//U10L014t8d9rNaCvLoEhJdwLw2p52dRY0EBlOJ9lno3dchCET9JJlunH4FMeCXxIb64lq4lKr5iDfq6i5fzqQZkIphBCbimhWaHo0D5WA==
Received: from bimmer.. (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPSA id 5034D18003F2;
	Sun, 29 Mar 2026 11:17:08 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org,
	Tobias Gaertner <tob.gaertner@me.com>
Subject: [PATCH 0/2] ntfs3: fix OOB read and integer overflow in run_unpack()
Date: Sun, 29 Mar 2026 04:17:01 -0700
Message-ID: <20260329111704.411449-1-tob.gaertner@me.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=McRhep/f c=1 sm=1 tr=0 ts=69c90a36
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=wterkXhTeHrO-kwhCgEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA4NyBTYWx0ZWRfX0mjZvIVb/78n
 oc7PTYfWfPwUSJ8T/eQvD8QXYQWk2EwsJ0orxRWITQNGj57ZVC4s0bQz0kJpaO79fTVmkZzR1xB
 5HsErVZKAp8023aMhKVZ5NBWE1TiEGkB57taIQmiB2J2AzTivszje6XSh5kfRkd3pvrqSDIO14j
 Gy5CjZu7/VIUmlQhLGJLtsvzLejsxJR8pnuw3A6+kcWTAfflLQXqdMDiCfCN5kVsJLIF/SnFqOw
 KzXLfaNY+Gte3dPU4thH+BBefsKyk2V3cuDNQ4N4jdpKYKei2cdQZjlzLRtxIk4VSNSA4b6ZLMc
 ZhEfeXNsiYBEH8f/c1t21OaBYMsVe6T5xa6iblNEal1yKZqa4LY2mxI8WJF71E=
X-Proofpoint-GUID: YJHi_aX8l3JImBqmnsaizUWuuxM9ounT
X-Proofpoint-ORIG-GUID: YJHi_aX8l3JImBqmnsaizUWuuxM9ounT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_03,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=952 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603290087
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[me.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,me.com];
	TAGGED_FROM(0.00)[bounces-230879-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tob.gaertner@me.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[me.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,me.com:dkim,me.com:email,me.com:mid]
X-Rspamd-Queue-Id: 7490B351C24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tobias Gaertner <tob.gaertner@me.com>

Two bugs in run_unpack() found by fuzzing with a source-patched harness
(LibAFL + QEMU ARM64 system-mode):

Patch 1: run_unpack() checks `run_buf < run_last` at the loop top but
then reads size_size and offset_size bytes via run_unpack_s64() without
verifying they fit in the remaining buffer.  A crafted NTFS image with
truncated run data triggers a heap OOB read of up to 15 bytes on mount.

Patch 2: The volume boundary check `lcn + len > sbi->used.bitmap.nbits`
uses raw addition that can wrap for large values, bypassing the
validation.  CVE-2025-40068 added check_add_overflow() for adjacent
arithmetic but missed this instance.

Both bugs are present since NTFS3 was merged in 5.15.

Could CVE IDs be assigned for these two issues?

tobgaertner (2):
  ntfs3: add buffer boundary checks to run_unpack()
  ntfs3: fix integer overflow in run_unpack() volume boundary check

 fs/ntfs3/run.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.43.0


