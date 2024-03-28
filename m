Return-Path: <stable+bounces-26391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2987D870E60
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5641C2118F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675E27B3FD;
	Mon,  4 Mar 2024 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pe4JCizZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431B1C6AB;
	Mon,  4 Mar 2024 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588599; cv=none; b=N2TLqsd/M8rhkS+RPkN0LI1k0OP/3MGgHEqQlLoXpIm8SDGy/cpkQGe1lGw8vfGYCvr/Ujk09rIv65dm9GqC9IUn6HKlCT5efXbmWrlTktps6fO62GzOqlGdz/37VcaDdLn2R5QwFW9qL/KM3QR1oXz5orkAjudFSdU/1hemf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588599; c=relaxed/simple;
	bh=LOxRjuxRCTcOnlspJeNHO/Z/m8o714hBPR7TEg3Z2CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIkBHaIK9rhAfzEPGtHQxcs6m3kwkPS/Db1U6cjLV82iRlap2O8fBd5xVMSVWtHAYsBToAHQVAZIKaQhWE4rhf9zoUIACkeAamtE4rQaR9Y3Sx56aWvE+z5hDaQZ4Z52SRr9jDPou2X76oC3LWhvvHp0rY5P64KbNZ/Oz3tHdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pe4JCizZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE7FC43390;
	Mon,  4 Mar 2024 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588599;
	bh=LOxRjuxRCTcOnlspJeNHO/Z/m8o714hBPR7TEg3Z2CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pe4JCizZbjSdoWnKq//X+sv3ZfDPKj9sBb81rKV5Phmw5RpLVuxyJxAqztoQXFIqL
	 JO2zXgzfQPorlIDmE0+fO8elQisXq4M/Wt9w9FixuFHBv9sqQbglYUH04kuQGGeqg1
	 Ssyb9QRGgNKWXXalrVoH77yQRSEgjwudrRe19LpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/215] RDMA/core: Fix multiple -Warray-bounds warnings
Date: Mon,  4 Mar 2024 21:21:28 +0000
Message-ID: <20240304211557.792591930@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit aa4d540b4150052ae3b36d286b9c833a961ce291 ]

GCC-13 (and Clang)[1] does not like to access a partially allocated
object, since it cannot reason about it for bounds checking.

In this case 140 bytes are allocated for an object of type struct
ib_umad_packet:

        packet = kzalloc(sizeof(*packet) + IB_MGMT_RMPP_HDR, GFP_KERNEL);

However, notice that sizeof(*packet) is only 104 bytes:

struct ib_umad_packet {
        struct ib_mad_send_buf *   msg;                  /*     0     8 */
        struct ib_mad_recv_wc *    recv_wc;              /*     8     8 */
        struct list_head           list;                 /*    16    16 */
        int                        length;               /*    32     4 */

        /* XXX 4 bytes hole, try to pack */

        struct ib_user_mad         mad __attribute__((__aligned__(8))); /*    40    64 */

        /* size: 104, cachelines: 2, members: 5 */
        /* sum members: 100, holes: 1, sum holes: 4 */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

and 36 bytes extra bytes are allocated for a flexible-array member in
struct ib_user_mad:

include/rdma/ib_mad.h:
120 enum {
...
123         IB_MGMT_RMPP_HDR = 36,
... }

struct ib_user_mad {
        struct ib_user_mad_hdr     hdr;                  /*     0    64 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        __u64                      data[] __attribute__((__aligned__(8))); /*    64     0 */

        /* size: 64, cachelines: 1, members: 2 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(8)));

So we have sizeof(*packet) + IB_MGMT_RMPP_HDR == 140 bytes

Then the address of the flex-array member (for which only 36 bytes were
allocated) is casted and copied into a pointer to struct ib_rmpp_mad,
which, in turn, is of size 256 bytes:

        rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;

struct ib_rmpp_mad {
        struct ib_mad_hdr          mad_hdr;              /*     0    24 */
        struct ib_rmpp_hdr         rmpp_hdr;             /*    24    12 */
        u8                         data[220];            /*    36   220 */

        /* size: 256, cachelines: 4, members: 3 */
};

The thing is that those 36 bytes allocated for flex-array member data
in struct ib_user_mad onlly account for the size of both struct ib_mad_hdr
and struct ib_rmpp_hdr, but nothing is left for array u8 data[220].
So, the compiler is legitimately complaining about accessing an object
for which not enough memory was allocated.

Apparently, the only members of struct ib_rmpp_mad that are relevant
(that are actually being used) in function ib_umad_write() are mad_hdr
and rmpp_hdr. So, instead of casting packet->mad.data to
(struct ib_rmpp_mad *) create a new structure

struct ib_rmpp_mad_hdr {
        struct ib_mad_hdr       mad_hdr;
        struct ib_rmpp_hdr      rmpp_hdr;
} __packed;

and cast packet->mad.data to (struct ib_rmpp_mad_hdr *).

Notice that

        IB_MGMT_RMPP_HDR == sizeof(struct ib_rmpp_mad_hdr) == 36 bytes

Refactor the rest of the code, accordingly.

Fix the following warnings seen under GCC-13 and -Warray-bounds:
drivers/infiniband/core/user_mad.c:564:50: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:566:42: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:618:25: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:622:44: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]

Link: https://github.com/KSPP/linux/issues/273
Link: https://godbolt.org/z/oYWaGM4Yb [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/ZBpB91qQcB10m3Fw@work
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/user_mad.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index d96c78e436f98..5c284dfbe6923 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -131,6 +131,11 @@ struct ib_umad_packet {
 	struct ib_user_mad mad;
 };
 
+struct ib_rmpp_mad_hdr {
+	struct ib_mad_hdr	mad_hdr;
+	struct ib_rmpp_hdr      rmpp_hdr;
+} __packed;
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/ib_umad.h>
 
@@ -494,11 +499,11 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 			     size_t count, loff_t *pos)
 {
 	struct ib_umad_file *file = filp->private_data;
+	struct ib_rmpp_mad_hdr *rmpp_mad_hdr;
 	struct ib_umad_packet *packet;
 	struct ib_mad_agent *agent;
 	struct rdma_ah_attr ah_attr;
 	struct ib_ah *ah;
-	struct ib_rmpp_mad *rmpp_mad;
 	__be64 *tid;
 	int ret, data_len, hdr_len, copy_offset, rmpp_active;
 	u8 base_version;
@@ -506,7 +511,7 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	if (count < hdr_size(file) + IB_MGMT_RMPP_HDR)
 		return -EINVAL;
 
-	packet = kzalloc(sizeof *packet + IB_MGMT_RMPP_HDR, GFP_KERNEL);
+	packet = kzalloc(sizeof(*packet) + IB_MGMT_RMPP_HDR, GFP_KERNEL);
 	if (!packet)
 		return -ENOMEM;
 
@@ -560,13 +565,13 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		goto err_up;
 	}
 
-	rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;
-	hdr_len = ib_get_mad_data_offset(rmpp_mad->mad_hdr.mgmt_class);
+	rmpp_mad_hdr = (struct ib_rmpp_mad_hdr *)packet->mad.data;
+	hdr_len = ib_get_mad_data_offset(rmpp_mad_hdr->mad_hdr.mgmt_class);
 
-	if (ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)
+	if (ib_is_mad_class_rmpp(rmpp_mad_hdr->mad_hdr.mgmt_class)
 	    && ib_mad_kernel_rmpp_agent(agent)) {
 		copy_offset = IB_MGMT_RMPP_HDR;
-		rmpp_active = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+		rmpp_active = ib_get_rmpp_flags(&rmpp_mad_hdr->rmpp_hdr) &
 						IB_MGMT_RMPP_FLAG_ACTIVE;
 	} else {
 		copy_offset = IB_MGMT_MAD_HDR;
@@ -615,12 +620,12 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		tid = &((struct ib_mad_hdr *) packet->msg->mad)->tid;
 		*tid = cpu_to_be64(((u64) agent->hi_tid) << 32 |
 				   (be64_to_cpup(tid) & 0xffffffff));
-		rmpp_mad->mad_hdr.tid = *tid;
+		rmpp_mad_hdr->mad_hdr.tid = *tid;
 	}
 
 	if (!ib_mad_kernel_rmpp_agent(agent)
-	   && ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)
-	   && (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE)) {
+	    && ib_is_mad_class_rmpp(rmpp_mad_hdr->mad_hdr.mgmt_class)
+	    && (ib_get_rmpp_flags(&rmpp_mad_hdr->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE)) {
 		spin_lock_irq(&file->send_lock);
 		list_add_tail(&packet->list, &file->send_list);
 		spin_unlock_irq(&file->send_lock);
-- 
2.43.0




