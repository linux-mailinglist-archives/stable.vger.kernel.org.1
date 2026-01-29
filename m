Return-Path: <stable+bounces-212786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFq7A2x8e2kQFAIAu9opvQ
	(envelope-from <stable+bounces-212786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:27:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056BB16DC
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DE493004629
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CC72DA756;
	Thu, 29 Jan 2026 15:27:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849F2C159A;
	Thu, 29 Jan 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700454; cv=none; b=UdCaZ/oGsNybEo5g3JI1cRNjzb/GMhCCTu23SHQxX3npzW8r6HccmK8oejS/N7qZF5Xsm3wUPGlTnPnhmx+49yfq+VisIKehnHWW3Cl4xSX2qNmfmKE62TwyR/5xawZ8I3W9QQDItaHpxatmK4WRgMn9BKkrGs3OKOBLWIi8ztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700454; c=relaxed/simple;
	bh=odgCc5+aoK8mxQN6vNEY2yndFEFbv3fDCHjWgzYbJ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDLV4ZMwS9jTT7GkvN2B+0lWXiQn8lXy96hCN5xm8aPwbKG9kEPNwZKaQNV1E5wpSnLWZj0CUFTkjie+Ba3kMeHNQt74JdNVmA5lNmnuJOVZCd5p6qcfA8TyXBfbK+dvuKncFBvjeXknnpL48qo+3jQYbMqFQ54KqztynhQwsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 366DD1576;
	Thu, 29 Jan 2026 07:27:24 -0800 (PST)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1593F73F;
	Thu, 29 Jan 2026 07:27:29 -0800 (PST)
Message-ID: <299083f7-07e4-436e-ba56-36901aba2855@arm.com>
Date: Thu, 29 Jan 2026 15:27:28 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Reject unsupported hardware configurations
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <bb47722fc593baf1e1cc0f944089592a4ec708da.1769695523.git.robin.murphy@arm.com>
 <aXttVVoVUQoIjWG6@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aXttVVoVUQoIjWG6@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212786-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:url,arm.com:mid]
X-Rspamd-Queue-Id: 1056BB16DC
X-Rspamd-Action: no action

On 29/01/2026 2:23 pm, Mark Rutland wrote:
> On Thu, Jan 29, 2026 at 02:11:22PM +0000, Robin Murphy wrote:
>> So far we've been fairly lax about accepting both unknown CMN models
>> (at least with a warning), and unknown revisions of those which we
>> do know, as although things do frequently change between releases,
>> typically enough remains the same to be somewhat useful for at least
>> some basic bringup checks. However, we also make assumptions of the
>> maximum supported sizes and numbers of things in various places, and
>> there's no guarantee that something new might not be bigger and lead
>> to nasty array overflows. Make sure we only try to run on things that
>> actually match our assumptions and so will not risk memory corruption.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 7819e05a0dce ("perf/arm-cmn: Revamp model detection")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/arm-cmn.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 2903e01f951f..24fec53ceccc 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -2422,6 +2422,15 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>   			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
>>   			dn->portid_bits = xp->portid_bits;
>>   			dn->deviceid_bits = xp->deviceid_bits;
>> +			/*
>> +			 * Logical IDs are assigned from 0 per node type, so as
>> +			 * soon as we one bigger than expected, we can assume
>> +			 * there are more than we can cope with.
>> +			 */
>> +			if (dn->logid > CMN_MAX_NODES_PER_EVENT) {
>> +				dev_err(cmn->dev, "Invalid node number: %d\n", dn->logid);
>> +				return -ENODEV;
> 
> I think "Invalid" is ambiguous (it can read like we're saying the HW is
> wrong), and it would be better to say "Unsupported", or something to
> that effect, e.g.

Yeah, it's a bit fiddly, because "unsupported" doesn't just mean "the 
number in the driver could be bigger" either, these driver limits are 
based on the documented maximum sizes for any currently known product, i.e.:

https://developer.arm.com/documentation/107858/0203/About-CMN-S3-AE-/Configurable-options/Mesh-sizing-and-top-level-configuration

So while larger values might be "valid" for future products we don't 
know about, hardware claiming to be, say, a 16x16 CMN-650 would indeed 
arguably be "wrong".

> 	dev_err(cmn->dev, "Node number (%d) larger than supported (%d)\n",
> 		dn->logid, CMN_MAX_NODES_PER_EVENT)
> 
>> +			}
>>   
>>   			switch (dn->type) {
>>   			case CMN_TYPE_DTC:
>> @@ -2499,6 +2508,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>   		cmn->mesh_x = cmn->num_xps;
>>   	cmn->mesh_y = cmn->num_xps / cmn->mesh_x;
>>   
>> +	if (max(cmn->mesh_x, cmn->mesh_y) > CMN_MAX_DIMENSION) {
>> +		dev_err(cmn->dev, "Invalid mesh size: %dx%d\n", cmn->mesh_x, cmn->mesh_y);
> 
> Likewise:
> 
> 	dev_err(cmn->dev, "Mesh size (%%dx%d) larger than supported
> 		(%d)\n", cmn->mesh_x, cmn->mesh_y, CMN_MAX_DIMENSION);
> 
>> +		return -ENODEV;
>> +	}
>>   	/* 1x1 config plays havoc with XP event encodings */
>>   	if (cmn->num_xps == 1)
>>   		dev_warn(cmn->dev, "1x1 config not fully supported, translate XP events manually\n");
> 
> ... or you could align with the wording here.

That one is different because it *is* purely a driver limitation - the 
different event encoding is known, it's just that having to have dynamic 
format attributes for the relevant event aliases would be a massive pain 
to implement, and so far nobody's asked for it. So this is just a 
reminder to the user that in this situation the "p0" aliases will 
actually encode events for port 4, "n" means port 0, etc., per the TRM:

https://developer.arm.com/documentation/101569/0300/Programmers-model/Register-descriptions/XP-register-descriptions/por-mxp-pmu-event-sel?lang=en

This is aligned with the "invalid device node type" message (other than 
capitalisation, bah!) that's been there from day 1 to fail probing on 
anything so new and unknown that it has components we can't even comprehend.

> Aside from the specific wording for the messages, this looks god to me.

Hallelujah!

Thanks,
Robin.

