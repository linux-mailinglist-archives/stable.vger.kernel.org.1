Return-Path: <stable+bounces-212867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMEBHOOYfGmJNwIAu9opvQ
	(envelope-from <stable+bounces-212867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 12:41:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA7CBA253
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5014300E16F
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7E36C5A2;
	Fri, 30 Jan 2026 11:41:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2636C581;
	Fri, 30 Jan 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773279; cv=none; b=dDst4Mern8Vy0KRzGOqbI9rpJmRtRY57oE4yc8u+KELCSS6Sru34uAqivScYEzW3AJlIkrZGf4oNY1zdpLfgEfp925XW/WWGUQtcxooTdRHNgKonoKx0hbJjY1UtqBRbGnnukx2MySFjyEAA/Do7e5tgyDggJAbSTS+CSDIBSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773279; c=relaxed/simple;
	bh=gKtXQPkOlolhO4IR2YKLStviH+5v/4HPSgCEemDemBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7kDLJ6YvVp8jSw51PA8fuvGUKOlHYpTbGVkMAB0Ul0QqTGycKDpl7bGmqTkVm75oSYYLK0b9fZwn2kCOu+R80Mf3NOZDYpjseTRZcoPqNxlIaKFdOPx4N8qk/saD2sELdHz3Y+8bo4eetrzu4987MdXm1l1gWKcDo8hERkjejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E6DD153B;
	Fri, 30 Jan 2026 03:41:10 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAD213F73F;
	Fri, 30 Jan 2026 03:41:15 -0800 (PST)
Message-ID: <cdbea011-63de-4533-94e8-5a2a18c8e545@arm.com>
Date: Fri, 30 Jan 2026 11:41:13 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Reject unsupported hardware configurations
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: will@kernel.org, mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <bb47722fc593baf1e1cc0f944089592a4ec708da.1769695523.git.robin.murphy@arm.com>
 <0b85786d-ab5c-e9ed-f060-e7854810b1bb@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0b85786d-ab5c-e9ed-f060-e7854810b1bb@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212867-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBA7CBA253
X-Rspamd-Action: no action

On 2026-01-30 3:57 am, Ilkka Koskinen wrote:
> 
> 
> Hi Robin,
> 
> On Thu, 29 Jan 2026, Robin Murphy wrote:
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
>> drivers/perf/arm-cmn.c | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 2903e01f951f..24fec53ceccc 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -2422,6 +2422,15 @@ static int arm_cmn_discover(struct arm_cmn 
>> *cmn, unsigned int rgn_offset)
>>             arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
>>             dn->portid_bits = xp->portid_bits;
>>             dn->deviceid_bits = xp->deviceid_bits;
>> +            /*
>> +             * Logical IDs are assigned from 0 per node type, so as
>> +             * soon as we one bigger than expected, we can assume
> 
> Should that be something like:
> 
>              "...as soon as we see one bigger than expected.."

Erm, indeed "see" is what I was trying to type... apparently it didn't 
make it all the way to my fingers.

> Other than that, the patch looks good to me.
> 
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Thanks!

Robin.

> 
> Cheers, Ilkka
> 
>> +             * there are more than we can cope with.
>> +             */
>> +            if (dn->logid > CMN_MAX_NODES_PER_EVENT) {
>> +                dev_err(cmn->dev, "Invalid node number: %d\n", dn- 
>> >logid);
>> +                return -ENODEV;
>> +            }
>>
>>             switch (dn->type) {
>>             case CMN_TYPE_DTC:
>> @@ -2499,6 +2508,10 @@ static int arm_cmn_discover(struct arm_cmn 
>> *cmn, unsigned int rgn_offset)
>>         cmn->mesh_x = cmn->num_xps;
>>     cmn->mesh_y = cmn->num_xps / cmn->mesh_x;
>>
>> +    if (max(cmn->mesh_x, cmn->mesh_y) > CMN_MAX_DIMENSION) {
>> +        dev_err(cmn->dev, "Invalid mesh size: %dx%d\n", cmn->mesh_x, 
>> cmn->mesh_y);
>> +        return -ENODEV;
>> +    }
>>     /* 1x1 config plays havoc with XP event encodings */
>>     if (cmn->num_xps == 1)
>>         dev_warn(cmn->dev, "1x1 config not fully supported, translate 
>> XP events manually\n");
>> -- 
>> 2.39.2.101.g768bb238c484.dirty
>>
>>
>>


