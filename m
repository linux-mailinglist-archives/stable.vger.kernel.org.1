Return-Path: <stable+bounces-27588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC887A7EF
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 13:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3CF1C21BA3
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122E93DBBA;
	Wed, 13 Mar 2024 12:58:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FC2E629;
	Wed, 13 Mar 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334725; cv=none; b=Su/6F6Q738tzwhC588P3aTKZ4NKjFnk0eVlLe9EeNh45M7w6617UE3umYljKmJlbBjX2cQl/vqkbipxxAGFuwdmKwF5ipifI1sIS7wKNd5S2myotKbThTpCW6Esqgosuzd5ezem4LlzjRRptumXam9pi9QiVjpcMZ3eq089jLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334725; c=relaxed/simple;
	bh=rpkWX2Y33GUzl/mxaa8r3wp6Ogsu+d1lAVmnx4MxqLE=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=pi/uufPcOtAXvMEzdQiUiSp3Apdjz3rWdhc2NOu73z5QIjy5Gse4p4RCk8vBhpC+7gVWUMleAB6RvRbzMv3b3uyL4PtnMcDY0iCK1FKQX3FDTwgKJJVYpjC7uYR3gWOAP43j9WSdy4WR53gjJuPA7k+Z6eNHj21Rp/5sovJOepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:39550)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rkNXJ-00H1bY-N3; Wed, 13 Mar 2024 06:16:45 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:46688 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rkNXI-004qp3-Ax; Wed, 13 Mar 2024 06:16:45 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Pavin Joseph <me@pavinjoseph.com>,  Simon Horman <horms@verge.net.au>,
  kexec@lists.infradead.org,  Eric Hagberg <ehagberg@gmail.com>,
  dave.hansen@linux.intel.com,  regressions@lists.linux.dev,
  stable@vger.kernel.org
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
	<ZensTNC72DJeaYMo@swahl-home.5wahls.com>
	<CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
	<ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
	<42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
	<ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
Date: Wed, 13 Mar 2024 07:16:23 -0500
In-Reply-To: <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com> (Steve Wahl's message of
	"Tue, 12 Mar 2024 17:02:06 -0500")
Message-ID: <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rkNXI-004qp3-Ax;;;mid=<87cyryxr6w.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18sVY/cAP35iOPKjLWyn/7yGz20+NXnxZQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Steve Wahl <steve.wahl@hpe.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 649 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (1.7%), b_tie_ro: 10 (1.5%), parse: 0.98
	(0.2%), extract_message_metadata: 24 (3.7%), get_uri_detail_list: 4.0
	(0.6%), tests_pri_-2000: 18 (2.8%), tests_pri_-1000: 2.4 (0.4%),
	tests_pri_-950: 1.23 (0.2%), tests_pri_-900: 1.00 (0.2%),
	tests_pri_-90: 127 (19.6%), check_bayes: 116 (17.9%), b_tokenize: 12
	(1.8%), b_tok_get_all: 18 (2.8%), b_comp_prob: 3.9 (0.6%),
	b_tok_touch_all: 79 (12.2%), b_finish: 0.94 (0.1%), tests_pri_0: 446
	(68.7%), check_dkim_signature: 0.61 (0.1%), check_dkim_adsp: 8 (1.2%),
	poll_dns_idle: 0.34 (0.1%), tests_pri_10: 3.1 (0.5%), tests_pri_500:
	11 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Steve Wahl <steve.wahl@hpe.com> writes:

> [*really* added kexec maintainers this time.]
>
> Full thread starts here:
> https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
>
> On Wed, Mar 13, 2024 at 12:12:31AM +0530, Pavin Joseph wrote:
>> On 3/12/24 20:43, Steve Wahl wrote:
>> > But I don't want to introduce a new command line parameter if the
>> > actual problem can be understood and fixed.  The question is how much
>> > time do I have to persue a direct fix before some other action needs
>> > to be taken?
>> 
>> Perhaps the kexec maintainers [0] can be made aware of this and you could
>> coordinate with them on a potential fix?
>> 
>> Currently maintained by
>> P:      Simon Horman
>> M:      horms@verge.net.au
>> L:      kexec@lists.infradead.org
>
> Probably a good idea to add kexec people to the list, so I've added
> them to this email.
>
> Everyone, my recent patch to the kernel that changed identity mapping:
>
> 7143c5f4cf2073193 x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
>
> ... has broken kexec on a few machines.  The symptom is they do a full
> BIOS reboot instead of a kexec of the new kernel.  Seems to be limited
> to AMD processors, but it's not all AMD processors, probably just some
> characteristic that they happen to share.
>
> The same machines that are broken by my patch, are also broken in
> previous kernels if you add "nogbpages" to the kernel command line
> (which makes the identity map bigger, "nogbpages" doing for all parts
> of the identity map what my patch does only for some parts of it).
>
> I'm still hoping to find a machine I can reproduce this on to try and
> debug it myself.
>
> If any of you have any assistance or advice to offer, it would be most
> welcome!

Kexec happens on identity mapped page tables.

The files of interest are machine_kexec_64.c and relocate_kernel_64.S

I suspect either the building of the identity mappged page table in
machine_kexec_prepare, or the switching to the page table in
identity_mapped in relocate_kernel_64.S is where something goes wrong.

Probably in kernel_ident_mapping_init as that code is directly used
to build the identity mapped page tables.

Hmm.

Your change is commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only
where full GB page should be mapped.")

Given the simplicity of that change itself my guess is that somewhere in
the first 1Gb there are pages that needed to be mapped like the idt at 0
that are not getting mapped.

Reading through the changelog:
>   x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
>    
>    When ident_pud_init() uses only gbpages to create identity maps, large
>    ranges of addresses not actually requested can be included in the
>    resulting table; a 4K request will map a full GB.  On UV systems, this
>    ends up including regions that will cause hardware to halt the system
>    if accessed (these are marked "reserved" by BIOS).  Even processor
>    speculation into these regions is enough to trigger the system halt.
>    
>    Only use gbpages when map creation requests include the full GB page
>    of space.  Fall back to using smaller 2M pages when only portions of a
>    GB page are included in the request.
>    
>    No attempt is made to coalesce mapping requests. If a request requires
>    a map entry at the 2M (pmd) level, subsequent mapping requests within
>    the same 1G region will also be at the pmd level, even if adjacent or
>    overlapping such requests could have been combined to map a full
>    gbpage.  Existing usage starts with larger regions and then adds
>    smaller regions, so this should not have any great consequence.
>    
>    [ dhansen: fix up comment formatting, simplifty changelog ]
>    
>    Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>    Cc: stable@vger.kernel.org
>    Link: https://lore.kernel.org/all/20240126164841.170866-1-steve.wahl%40hpe.com

I know historically that fixed mtrrs were used so that the first 1GiB
could be covered with page tables and cause problems.

I suspect whatever those UV systems are more targeted solution would be
to use the fixed mtrrs to disable caching and speculation on the
problematic ranges rather than completely changing the fundamental logic
of how pages are mapped.

Right now it looks like you get to play a game of whack-a-mole with
firmware/BIOS tables that don't mention something important, and
ensuring the kernel maps everything important in the first 1GiB.

It might be worth setting up early printk on some of these systems
and seeing if the failure is in early boot up of the new kernel (that is
using kexec supplied identity mapped pages) rather than in kexec per-se.

But that is just my guess at the moment.

Eric




>> I hope the root cause can be fixed instead of patching it over with a flag
>> to suppress the problem, but I don't know how regressions are handled here.
>
> That would be my preference as well.
>
> Thanks,
>
> --> Steve Wahl

