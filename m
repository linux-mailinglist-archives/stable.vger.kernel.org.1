Return-Path: <stable+bounces-222565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEQpJ3ljpWmJ/QUAu9opvQ
	(envelope-from <stable+bounces-222565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:16:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCA1D6403
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E0C3028EC7
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B5395DBB;
	Mon,  2 Mar 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a5h1WlNZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83E38F655;
	Mon,  2 Mar 2026 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446276; cv=none; b=BTYUdujT2AbfnGYcv0KXCvZyjFdM7rgPtw8tDgvloN1TI5hRnX7BDMkGCtRue8Mb4Y1G1e57nucxUxyPFAJ/pV17pTXdGsVwdDJROP4tlltc0NNuaKRCt0cWYp9/Oq+bvwakkYTaVRoUA0YSlULmsj/AiGfmFVT9hoX6MA9LX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446276; c=relaxed/simple;
	bh=eMYF1zl7T6/xzZ7sWT5fmA+Bbsptb4hlAOiJyzhRqzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNGXl4thXtGIPff/t2xWm8AqrAbNbzBq4vEC/38tLrb9etQDv1xsmFuCEldpE817BRbOiskmonHXZMu5obfkt7DiyiL8AWJJXuaeh8qxVZ+3BsTWNdMwwHqreWBHWNaHwKbi5/8kZvt3GdVw6wTnmFeJPovglmmc3+CNV2HECvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a5h1WlNZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621NOYaG2517891;
	Mon, 2 Mar 2026 10:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=7/bl5cRsyHtOyV1Kv0zJkYeok+unS5Dv+k2P2C5RBJE=; b=a5h1WlNZXc8o
	yp+CNR9+/dPA6jidKVmG4m10eLi/bwVHUSiOis+Dj3FUEcaXkzSzjpbGtaqkk3EI
	vVPmP+diM66NXxK2d8/6kFharhB9fo7HLzn12Nhy8HyR9nIQso1KE2QhZTvURI3s
	SmMEHyXbcUqPS9Hi05DYFIelnX2iuRz57Iy1vRRSzXju2sjYZJVUhHZVMvsw4t5P
	WBKrLdtAxMBZoR8S18TDcNv1W6fPpa8Cz9726NP8uIylGqJP0W+Ka8gEy0f4/dwl
	eVFfOQ5XHgL909yYAv4/nTU5j3kOyfJ9QT4T5OWP9i3eOuYklPVHD4NLwkibYicc
	LaOsuq/93w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrhww73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 10:11:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6226aTEa027692;
	Mon, 2 Mar 2026 10:11:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj543f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 10:11:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622AB5N342271150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 10:11:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B367C20043;
	Mon,  2 Mar 2026 10:11:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0ED820040;
	Mon,  2 Mar 2026 10:11:05 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 10:11:05 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vx0Ez-00000008wJJ-1a9L;
	Mon, 02 Mar 2026 11:11:05 +0100
Date: Mon, 2 Mar 2026 11:11:05 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        bhelgaas@google.com, helgaas@kernel.org, sebott@linux.ibm.com,
        schnelle@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <20260302101105.GA1971507@p1gen4-pw042f0m>
References: <20260228120138.51197-2-ionut.nechita@windriver.com>
 <20260228120138.51197-4-ionut.nechita@windriver.com>
 <mvhrbhqxnxeitx4incfykvlgtcfs2jcrlje2warhujzvbyns4e@7eyme5xdea7g>
 <20260228163955.GH13050@p1gen4-pw042f0m>
 <vogl77sk53qas4nnqb4jrmduofxhuhpcgipdkab5meuswd3hhr@l6rfqqndskfv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vogl77sk53qas4nnqb4jrmduofxhuhpcgipdkab5meuswd3hhr@l6rfqqndskfv>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a56240 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=t7CeM3EgAAAA:8 a=PSTKHmiy-ejbmqsSMdMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4NCBTYWx0ZWRfXwModTvjcUU5t
 4NgqPj+GD6z+jO0Q+L6tZx8XJWNipb0YT+EQXCOue7y1A/x1LQtqqnd4ASFQg0x6saaH6hB8RZz
 UmPJ1IAnlZw4ou4m6NsmvwWc+HO+ME+qoNMpQu8KhsQyC+AM6qFatQrNqXRqqb6BoYdtejgVJXd
 Px/V/bVc/+8mm7HT8lVol6iuhoYcCVG/8eLFxbVhICud0gGwUqUQTpU7/p9ESNQaVCebRNGBDoN
 K6uK4/6OAzPwAtFsvs3odhzzMLiWOH0SRGdIqiu/tefuWVfUGfGqfoHNoLLRX9fxX5yJOgNyQ1j
 yyA9gm9iCgJkwkVyuDihoTzHwiYueS2HRzayr+1jMQQk9MhkJaesl7IVG6JnOQMs9sp8qBnMKEb
 4D+U8En5iiA1EUqz2xzd5QtXxN49WTGaGiflw6WpSuJKEyJWZJlezZ9sab2cMtIdOSrDu217aRy
 l013tV5OZtEnSulHOYQ==
X-Proofpoint-GUID: Pk2ofLXGp0IKFzC9Y5sIBxxbRHwUZtnn
X-Proofpoint-ORIG-GUID: Qx8xGbv4xa-jczP4CHCkUneqwTE1fy1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222565-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[windriver.com,google.com,kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47FCA1D6403
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:43:04AM +0530, Manivannan Sadhasivam wrote:
> On Sat, Feb 28, 2026 at 05:39:55PM +0100, Benjamin Block wrote:
> > On Sat, Feb 28, 2026 at 08:43:33PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Feb 28, 2026 at 02:01:40PM +0200, Ionut Nechita (Wind River) wrote:
> > > > From: Ionut Nechita <ionut.nechita@windriver.com>
> > > > Instead, introduce owner tracking for pci_rescan_remove_lock via a new
> > > > pci_lock_rescan_remove_reentrant() helper. This function checks if the
> > > > current task already holds the lock:
> > > >  - If the lock is not held: acquires it and returns true, providing
> > > >    full serialization against concurrent hotplug events (including
> > > >    platform-generated events on s390).
> > > >  - If the lock is already held by the current task (reentrant call from
> > > >    remove_store or sriov_numvfs_store paths): returns false without
> > > >    re-acquiring, avoiding deadlock while the caller already provides
> > > >    the necessary serialization.
> > > >  - If the lock is held by another task (concurrent hotplug): blocks
> > > >    until the lock is released, then acquires it, providing complete
> > > >    serialization. This is the key improvement over a trylock approach.
> > > 
> > > Just curious. Why can't you use mutex_trylock() here?
> > 
> > One problem with mutex_trylock() is we don't know whether we ourself or
> > someone else is holding the lock when it fails, we just know someone holds it;
> > and we can't wait for someone else to release it when there is a chance we
> > hold it ourself already. That was the problem with
> > 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
> > before it was reverted.
> 
> Okay, thanks for the info. I also failed to notice the mention of 'trylock' in
> the cover letter.
> 
> But I think, instead of caching the owner task struct locally, you can make use
> of mutex_get_owner() to extact the embedded owner task struct.

True. Didn't know/see that one, yet. We'd have to treat the return value as
`struct task_struct *` to compare it, but I see debug_show_blocker() already
does that effectively (when I saw the function returns ulong, I thought it was
meant to be treated as transparent value).

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

