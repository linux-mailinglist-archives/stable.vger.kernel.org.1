Return-Path: <stable+bounces-6489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B948280F5A9
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 19:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEAD1C20BB5
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDD07F54E;
	Tue, 12 Dec 2023 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="iuqBpxMz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6484BD
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 10:47:53 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCDAM8j023234;
	Tue, 12 Dec 2023 10:47:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=kmhdh
	E7FECI83mwVDWoNt4ckeI8eZ+d7VFLWS/THbKA=; b=iuqBpxMzcncxOAQwHVLnw
	5Y6HyayNJ8iJTNDYAsnw7w3bTRMH0N/NtABfXnotNXpaAyKQu5FMvBrb8nIhvfaT
	c0KWGR0+iq4rK4NuAFXDh8JUiAxZ31xeDRLTX8Cdac2TWq17D5UtZdVhk/tVXoH5
	riQ22SN4TPEFJlenXt2LY6Udn4WgY1mXCm2u/eTgThsDpFtmyCauWdldTA/Qp3Hd
	EMFB5HsWmQc0IvK4bxp4anFgE5OVXXsT1MJyw1rkw6tukAVwwQb//wvQSVv6WWj5
	dKsEF8Rb28eraSxOZ4Nja5kNq3axBv3Re2w8XhA/R7s1ZLRxR4CmXrrOGofkIhv3
	w==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uwyxj9mj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Dec 2023 10:47:46 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 10:47:50 -0800
Received: from yow-lpggp3.wrs.com (128.224.137.13) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 10:47:50 -0800
From: <paul.gortmaker@windriver.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
Date: Tue, 12 Dec 2023 13:47:44 -0500
Message-ID: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k4fISsCT-FOL_mgohZYFtK89Mj2mnyTF
X-Proofpoint-GUID: k4fISsCT-FOL_mgohZYFtK89Mj2mnyTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120143

From: Paul Gortmaker <paul.gortmaker@windriver.com>

This is a bit long, but I've never touched this code and all I can do is
compile test it.  So the below basically represents a capture of my
thought process in fixing this for the v5.15.y-stable branch.

I am hoping the folks who normally work with this code can double check
that I didn't get off-track somewhere...


CVE-2023-38431 points at commit 368ba06881c3 ("ksmbd: check the
validation of pdu_size in ksmbd_conn_handler_loop") as the fix:

https://nvd.nist.gov/vuln/detail/CVE-2023-38431

For convenience, here is a link to the fix:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/smb/server?id=368ba06881c3

It was added in v6.4

git describe --contains 368ba06881c3
v6.4-rc6~2^2~1

...and backported to several stable releases.  But just not v5.15.

Why not v5.15?  If we look at the code the fix patches with "git blame"
we get commit 0626e6641f6b4 ("cifsd: add server handler for central
processing and tranport layers")

$git describe --contains 0626e6641f6b4
v5.15-rc1~183^2~94

So that would have been the commit the "Fixes:" line would have pointed
at if it had one.

Applying the fix to v5.15 reveals two problems.  The 1st is a trivial
file rename (fs/smb/server/connection.c --> fs/ksmbd/connection.c for
v5.15) and then the commit *applies*.   The 2nd problem is only revealed
at compile time...

The compile fails because the v5.15 baseline does not have smb2_get_msg().
Where does that come from?

commit cb4517201b8acdb5fd5314494aaf86c267f22345
Author: Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed Nov 3 08:08:44 2021 +0900

    ksmbd: remove smb2_buf_length in smb2_hdr

git describe --contains cb4517201b8a
v5.16-rc1~21^2~6

So now we see why v5.15 didn't get a linux-stable backport by default.
In cb4517201b8a we see:

+static inline void *smb2_get_msg(void *buf)
+{
+       return buf + 4;
+}

However we can't just take that context free of the rest of the commit,
and then glue it into v5.15.  The whole reason the function exists is
because a length field of 4 was removed from the front of a struct.
If we look at the typical changes the struct change caused, we see:

-       struct smb2_hdr *rcv_hdr2 = work->request_buf;
+       struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);

If we manually inline that, we obviously get:

-       struct smb2_hdr *rcv_hdr2 = work->request_buf;
+       struct smb2_hdr *rcv_hdr2 = work->request_buf + 4;

Now consider the lines added in the fix which is post struct reduction:

+#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)

+               if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+                   SMB2_PROTO_NUMBER) {
+                       if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+                               break;
+               }

...and if we inline/expand everything, we get:

+               if (((struct smb2_hdr *)(conn->request_buf + 4))->ProtocolId ==
+                   SMB2_PROTO_NUMBER) {
+                       if (pdu_size < (sizeof(struct smb2_hdr) + 4))
+                               break;
+               }

And so, by extension the v5.15 code, which is *pre* struct reduction, would
simply not have the "+4" and hence be:

+               if (((struct smb2_hdr *)(conn->request_buf))->ProtocolId ==
+                   SMB2_PROTO_NUMBER) {
+                       if (pdu_size < (sizeof(struct smb2_hdr)))
+                               break;
+               }

If we then put the macro back (without the 4), the v5.15 version would be:

+#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr))

+               if (((struct smb2_hdr *)(conn->request_buf))->ProtocolId ==
+                   SMB2_PROTO_NUMBER) {
+                       if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+                               break;
+               }

And so that is what I convinced myself is right to put in the backport.

If you read/reviewed this far - thanks!
Paul.

---

Namjae Jeon (1):
  ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop

 fs/ksmbd/connection.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.40.0


