Return-Path: <stable+bounces-58156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2D928F2B
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 00:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1019A285D8C
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268F13F432;
	Fri,  5 Jul 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qNG75Nez"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458611F61C
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720217094; cv=none; b=LyF2wLMJ8x08jIdCtIv6jYW1WyTHKbbCy+nFICh/vFMzGj8MxzTV7YQsPy50a58RpbHfD27K+yQupuGOK2rJeBkRyo2ZLPw4TeDRyHSmG/NJHhbZ7/L4L+dNzXmVaIZ3vcreXdQ2SSUd899P7m6f4hdATAZP7OeiNR4W2LI4zck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720217094; c=relaxed/simple;
	bh=8BbtFQsRKR3qhdLZDq90bNTlPf597mEZTkUi0dxLnVs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=sAxMboAmKNRtMWQNQ8KwdJ2qos8j+nQ6QGK2S0O6AxZOBrSHgPRnF+Hu7+8SpkXJnX4m7FrvKo7+w/XNH8ZSjHc38cCNIqJqG7QhkXX3Vo7d0wiPvxBjFBQYGqDKOIfxZYyB1wfrwfOTPz/ul0P6exInQv+NgK+hqhtfyV7Mf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qNG75Nez; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465ISdOC025010;
	Fri, 5 Jul 2024 22:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	36gykJ4YcUn2l39O7AuvTluCShq38i4kYV8yrZ4Sxz0=; b=qNG75NezOIKgBUMi
	djtlbWVUvNGKjkjHVAL7wkR26QLIdWyCNv2FPSHjwxg7fXf78CdQIeTBO/0NV3JN
	VBLWAvLaEhVcKBMP4lnYs6S2vfYGZKB6FH7X+ZW2fUMcXNfe7lkwiQw8ZzB8Z9wb
	DmNGjFiOYbdaANRunKemx4hj09I9wgswsnO9XMBfL1R9UYppWZ2Tt/x4CFehXsiL
	BEwattundjAeJ+qYEk45gFppy48pq2/NtSHEPjdiZ5iAKkYMw8kobOicHeLxgOC5
	qVAF+17DFz/xv3I8Tgs6q71kGgOQCtHHRIIQ72cZ7O1NUGKB9Agvj/cW5pJEYkPu
	s5WmCA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406p4v0d3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 22:04:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 465L0LNY005953;
	Fri, 5 Jul 2024 22:04:31 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vkuqxpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 22:04:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 465M4SRf1770028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jul 2024 22:04:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F3D658052;
	Fri,  5 Jul 2024 22:04:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E564C58056;
	Fri,  5 Jul 2024 22:04:27 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.131.151])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jul 2024 22:04:27 +0000 (GMT)
Message-ID: <f127af3139a3d01d25472cf314e92adecedd06f0.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, stable@vger.kernel.org
Cc: GUO Zihua <guozihua@huawei.com>,
        John Johansen
 <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 05 Jul 2024 18:04:27 -0400
In-Reply-To: <20240704104303.3330331-1-roberto.sassu@huaweicloud.com>
References: <20240704104303.3330331-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TC_sm4TCPCrftapOSYIocRTnc1Edmkp4
X-Proofpoint-GUID: TC_sm4TCPCrftapOSYIocRTnc1Edmkp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_16,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050162

On Thu, 2024-07-04 at 12:43 +0200, Roberto Sassu wrote:
> From: GUO Zihua <guozihua@huawei.com>
> 
> A panic happens in ima_match_policy:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> PGD 42f873067 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh
> Kdump: loaded Tainted: P
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>                BIOS 0.0.0 02/06/2015
> RIP: 0010:ima_match_policy+0x84/0x450
> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39
>       7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d
>       f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea
>       44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> FS:  00007f5195b51740(0000)
> GS:ff3e278b12d40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ima_get_action+0x22/0x30
>  process_measurement+0xb0/0x830
>  ? page_add_file_rmap+0x15/0x170
>  ? alloc_set_pte+0x269/0x4c0
>  ? prep_new_page+0x81/0x140
>  ? simple_xattr_get+0x75/0xa0
>  ? selinux_file_open+0x9d/0xf0
>  ima_file_check+0x64/0x90
>  path_openat+0x571/0x1720
>  do_filp_open+0x9b/0x110
>  ? page_counter_try_charge+0x57/0xc0
>  ? files_cgroup_alloc_fd+0x38/0x60
>  ? __alloc_fd+0xd4/0x250
>  ? do_sys_open+0x1bd/0x250
>  do_sys_open+0x1bd/0x250
>  do_syscall_64+0x5d/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> This implies a possible sleep and violates limitations of RCU read-side
> critical sections on non-PREEMPT systems.
> 
> Sleeping within RCU read-side critical section might cause
> synchronize_rcu() returning early and break RCU protection, allowing a
> UAF to happen.
> 
> The root cause of this issue could be described as follows:
> > 	Thread A	|	Thread B	|
> > 			|ima_match_policy	|
> > 			|  rcu_read_lock	|
> > ima_lsm_update_rule	|			|
> >  synchronize_rcu	|			|
> > 			|    kmalloc(GFP_KERNEL)|
> > 			|      sleep		|
> ==> synchronize_rcu returns early
> >  kfree(entry)		|			|
> > 			|    entry = entry->next|
> ==> UAF happens and entry now becomes NULL (or could be anything).
> > 			|    entry->action	|
> ==> Accessing entry might cause panic.
> 
> To fix this issue, we are converting all kmalloc that is called within
> RCU read-side critical section to use GFP_ATOMIC.
> 
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> Cc: stable@vger.kernel.org
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> [PM: fixed missing comment, long lines, !CONFIG_IMA_LSM_RULES case]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> (cherry picked from commit 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
> Backporting notes:
> - Remove security_audit_rule_init() documentation changes
> - Add default return value parameter to call_int_hook()
>   in security_audit_rule_init()
> - Can be backported to 6.1.x, 5.15.x, 5.10.x

Thanks, Roberto.  I'll post a similar one for linux-6.8.y - linux-6.4.y.

Mimi


