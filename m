Return-Path: <stable+bounces-55798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B99170EC
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 21:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6951FB2575E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D8D17C7C8;
	Tue, 25 Jun 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IZv/9DE4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29317C7B5
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342589; cv=none; b=N8KsGSlPPnCQVjhUzzBFRUkt0ad+L9DVGJzVxlgEX5qu6wRLjgOh9hjoOoO6k+xyy56vH8nflpKX0TXZqbxOj3ymwHlnAPnDkchQJsGaz5KSmDH6AFXYyU6tuDwYpmXucgIornGSLHUBAMi1d0BNQta0l1aHkt3x0/9JA1P6ei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342589; c=relaxed/simple;
	bh=5dcM9TLCg7YuwKwaHuoYPc+hXJA45HKHYfJHLBgFkvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eswULHnJu+fx98vO5Z3Vm5V+BFchV1jJm5jti07C+u7qNmMa8JsUZDEPz9zy6Hn6kQL0p+7On2+r+yBdqadCBjB13Z3M6t7ZlE6TvjiXIXr9e+ItN8ieri1emi6Z9xWd/KSji7iXuXHWRv9yuMsOOJKm+JT+S5W56Y/28gX7/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IZv/9DE4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIqMIG011043;
	Tue, 25 Jun 2024 19:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	fz65OrhxZt2wcjOs09XmC5fDHQmwhvUb0HDyA743e78=; b=IZv/9DE47BVrIOCp
	9EERHAK2nq/+IMawPDZdPcT3QI940XPuoun5cUk1C51tyRdHVu3NkAnWJUkhun1G
	4XD0AU5yWVO07WIlFWbvRpH11lURIZjNfy8YFBK3N1Z10vKMVaa0RQJFlIUqPO7n
	F2hqAKiVoQdOmxic9lcCpX/w5gpjqab+lF5gO3+Z6GBbE1nkIPR2FMUKffmg0mAk
	/WfNtjWC5cQ3zTi3emp2qtGh6xezLn/jdApWAzUbgsgC9NwUP2XzJ/gBryqvmwQy
	wpdiHAFSHAdhVD7TmGlDbUdM6cQepWb7ljXXYmTmZg5oQR5skGdY69Wy5fAScCY7
	8VSt6g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4002s7g4xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 19:09:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIJrF3019548;
	Tue, 25 Jun 2024 19:09:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xq04em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 19:09:30 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45PJ9SAR14746288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:09:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC50E5805C;
	Tue, 25 Jun 2024 19:09:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4627558058;
	Tue, 25 Jun 2024 19:09:27 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 19:09:27 +0000 (GMT)
Message-ID: <be9c3320321571b391a068488e3a66bf63ca455c.camel@linux.ibm.com>
Subject: Re: FAILED: patch "[PATCH] ima: Avoid blocking in RCU read-side
 critical section" failed to apply to 6.6-stable tree
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: gregkh@linuxfoundation.org, guozihua@huawei.com, casey@schaufler-ca.com,
        john.johansen@canonical.com, stable@vger.kernel.org
Date: Tue, 25 Jun 2024 15:09:26 -0400
In-Reply-To: <CAHC9VhTcH8Y78i5=HGQdqtoF3j_qKJZGn2_EYU9dBK+amF-EgA@mail.gmail.com>
References: <2024062438-shaft-herbicide-4e7d@gregkh>
	 <7eaf494c90161d4df0855af9697a7be9e9c878b6.camel@linux.ibm.com>
	 <CAHC9VhTcH8Y78i5=HGQdqtoF3j_qKJZGn2_EYU9dBK+amF-EgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d0Uz-9Ql92KncjNqfkuds8blQw8dCSur
X-Proofpoint-GUID: d0Uz-9Ql92KncjNqfkuds8blQw8dCSur
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250139

On Tue, 2024-06-25 at 11:10 -0400, Paul Moore wrote:
> On Mon, Jun 24, 2024 at 8:06 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Mon, 2024-06-24 at 18:47 +0200, gregkh@linuxfoundation.org wrote:
> > > The patch below does not apply to the 6.6-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062438-shaft-herbicide-4e7d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> > > 
> > > Possible dependencies:
> > > 
> > > 9a95c5bfbf02 ("ima: Avoid blocking in RCU read-side critical section")
> > > 260017f31a8c ("lsm: use default hook return value in call_int_hook()")
> > > 923831117611 ("evm: Move to LSM infrastructure")
> > > 84594c9ecdca ("ima: Move IMA-Appraisal to LSM infrastructure")
> > > cd3cec0a02c7 ("ima: Move to LSM infrastructure")
> > > 06cca5110774 ("integrity: Move integrity_kernel_module_request() to IMA")
> > > b8d997032a46 ("security: Introduce key_post_create_or_update hook")
> > > 2d705d802414 ("security: Introduce inode_post_remove_acl hook")
> > > 8b9d0b825c65 ("security: Introduce inode_post_set_acl hook")
> > > a7811e34d100 ("security: Introduce inode_post_create_tmpfile hook")
> > > f09068b5a114 ("security: Introduce file_release hook")
> > > 8f46ff5767b0 ("security: Introduce file_post_open hook")
> > > dae52cbf5887 ("security: Introduce inode_post_removexattr hook")
> > > 77fa6f314f03 ("security: Introduce inode_post_setattr hook")
> > > 314a8dc728d0 ("security: Align inode_setattr hook definition with EVM")
> > > 779cb1947e27 ("evm: Align evm_inode_post_setxattr() definition with LSM infrastructure")
> > > 2b6a4054f8c2 ("evm: Align evm_inode_setxattr() definition with LSM infrastructure")
> > > 784111d0093e ("evm: Align evm_inode_post_setattr() definition with LSM infrastructure")
> > > fec5f85e468d ("ima: Align ima_post_read_file() definition with LSM infrastructure")
> > > 526864dd2f60 ("ima: Align ima_inode_removexattr() definition with LSM infrastructure")
> > 
> > The patch doesn't apply cleanly due to the '0' in security_audit_rule_init():
> >         return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> > 
> > Commit 260017f31a8c ("lsm: use default hook return value in call_int_hook()")
> > removed it.  Instead of backporting commit 260017f31a8c, adding the '0' would be
> > simpler.  This seems to be the only change needed for linux-6.8.y to 6.4.y.
> 
> Agreed.
> 
> > For linux-6.3.y to linux-6.2.y, commit b14faf9c94a6 ("lsm: move the audit hook
> > comments to security/security.c") also needs to be applied.
> > 
> > Paul, how do you normally handle backports?
> 
> Normally I just tag them accordingly and let the stable team handle
> it, with the understanding that the stable team only picks patches
> that have been explicitly marked for stable and not just anything with
> a 'Fixes:' tag.  I'm sure you remember when we discussed this
> recently, there shouldn't be anything new here.

Ok. This should have then been tagged for Stable.
> 
> The tricky part is what the patch fails to merge automatically.  It
> has been my experience that the stable team really doesn't try to do
> any manual merge fixups on the LSM, SELinux, or audit patches, so it
> is really up to me or someone else who cares enough to do the backport
> manually and resubmit.  See "option #3" in the stable kernel docs:
> 
> * https://docs.kernel.org/process/stable-kernel-rules.html#option-3
> 
> I've personally had some bad experiences working with the stable trees
> (YMMV) which combined with a chronic lack of time means that I rarely
> do a manual backport for the stable trees (the bug needs to be
> especially horrendous).  However, others are always free to submit
> backports, see the "option #3" link above.

Ok. Looks like option 3 is the way to go then.

Mimi


