Return-Path: <stable+bounces-200970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 914ADCBBD38
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83EFF3005A99
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278A2DAFB0;
	Sun, 14 Dec 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf7aZETZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50F223DFB
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765728160; cv=none; b=pivJNlkDEgdqU4pzZYP0C/QNK7qWt5z3ghGtmUUKOc7nbdJJ76NV7ab5aMfZbJN3uLn4pnWJOJtBf4Sb5fofNk330mGOrNofQeyI6c5/vorhFWoFZ0Dv/lyRYpLUm4nQSkc/fC5LFHiHbQgH1OrinLnGee6FBXSr161cirZlRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765728160; c=relaxed/simple;
	bh=WClbA3JP9PBCEQbLahbBZ/+egWdj23cqYt7+rBR+M8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLA+moF/NmUIbnk3K9fOeBtoLPigRI9nGzxO74xlFvYUDPDT7Fr0JHiLBaKe35y7opr+6RGigWUPoXG48QSBM7APf7UPw9SGV5S+2cihTOoO+lx8uGelEIhUpa072g23m1awiNB9CPqcUadArW1QfqGxBHEnpDP8NuW+nFU2uGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf7aZETZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b736d883ac4so422226666b.2
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765728156; x=1766332956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HRjVx+w0FUfej9H+if55vg50Zyzey3BxyfSJanV6SE=;
        b=Mf7aZETZqpALHFu3VbM2xBuKrNXrWug9+mg7W4T27vSOyLlucNUD8oESoWt0F2BkSd
         mLNolIohsR43r8TMH5wKcaGvCcf6o44LjbSF61vf1oTzSfkk7KWkrgg7DQ7BRbztASO7
         1UdxEJSs2bpcLfbWHCa0A8qiMVpGF1xK1BBukWg/Pp48bWthhkQCP0Xgbwe5H6hJMb6x
         WHzf2AcvdVBu2Js/YZH0Zro/+gAGxWrBJMMIdW3rCL9t+jk+uOixVfX18EdNi15yVXt7
         MY/yh4PUw45Tw33LCswO9tqVbwdml17/39LzdSOrh7H7bknQqMZyUsfzhB+zzyNrcZCx
         hw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765728156; x=1766332956;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HRjVx+w0FUfej9H+if55vg50Zyzey3BxyfSJanV6SE=;
        b=WXAXIABKQmsRDepGoajfno3ij3JxT0Yua6Y5VvgssxgBrMBxFOCn9CTrnPmI8OkUXv
         jhQSMvMZK+TTmDOC+XKJvus9wZAYSBfIDra2h0v9d3BDPrgMowLAxRW1ygQjXO2vdXDY
         i6hB6v3Zjnwam2Vd+15PhOELIGwP816MydPcWFdWWW56yeanr+MBH1U5s2qupaRmGcjK
         qX3yktlAM5bCIRkdktgslkplu0DOk1WJsU++EPogzzNoq3BPoh74HiCT+15aVUOCAen5
         lYuV71ou1UbA3VqQba4EmITVNhzUWp8nQFHzSYY04FBwNY68huQ5/O6p1Hz2CcxXkEIX
         uGag==
X-Forwarded-Encrypted: i=1; AJvYcCV+o3a3qT5Kl9cQ0A2yh5kpZM4N/g5DUoCfHHxVOAxe0wHlt0EqS+bP1qVRpFsSHOjL/zfvGPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1BszeLjfU35zUw27jbu6viqxuVgmkkyeCixA8Gd4vadvgcfu
	IdTDA3p7ZUQwDX5Mj1ov13mZCCdo/Q62E2733g+pMMKRZrAD/8ZUKa7c
X-Gm-Gg: AY/fxX4ZcvJRYvp8giKNFEOSccDl/iYpyP3hBv2SwxPHK3W/QhoU80F4xAT430iAXBW
	9WtugFtftDV3e+jiCSasdnxEyDyXbJYq+dxwnu1FbIct+NpSemGfztIYV+4qL2wuo2o8aN1tIRN
	sO1zP8qknMb/IQx5Yu0eeFz1XeLbpkneUnSBH3C7F5elfMb8vEngBfUNyZV9pDpA4iqw0qnhUKp
	oOBFiKL/7a5ZjKLjn0O5wYvvsZnlvxq6kFuFb+SEsIFcA4AJ3VBegsuy3DOcp1YEqOZH/ObbJEW
	oAA+FX+Sqm5a8MmMj2Yvn3Yp2Ll0Tk/1neC5mR4wutxknPxOSoNb3nuWwEZWpCs9zG9JXdmEFDQ
	JPmIScxtp0poNHRYLDguFFACLWNenLE0A1IVefSgnhpvMkaH2TXuHrVQpqPgWnzMYhorDmdK8CI
	beQkc7E3/cRFTLHcBn/IBWDX1Sq5jGEa/tkF6OyyA3fjTPMAo+XfeHh8Sj1Y2Km0pg6g8dhi5i
X-Google-Smtp-Source: AGHT+IFWOX+q/68f3C3UaXjuHgRyTcHnGkkYvoTOTSRdTMz0p4912j7OAGU1Gsmdx9vlNh9tWKRW1Q==
X-Received: by 2002:a17:907:60cb:b0:b73:880a:fdb7 with SMTP id a640c23a62f3a-b7d238fd2f5mr896492366b.35.1765728155474;
        Sun, 14 Dec 2025 08:02:35 -0800 (PST)
Received: from [192.168.0.2] (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm1132110266b.10.2025.12.14.08.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 08:02:34 -0800 (PST)
Message-ID: <39ba16a9-9b7d-4c26-91b5-cf775a7f8169@gmail.com>
Date: Sun, 14 Dec 2025 17:02:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
To: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tobias@waldekranz.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251214131204.4684-1-make24@iscas.ac.cn>
From: Jonas Gorski <jonas.gorski@gmail.com>
Content-Language: en-US
In-Reply-To: <20251214131204.4684-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/14/25 14:12, Ma Ke wrote:
> When of_find_net_device_by_node() successfully acquires a reference to

Your subject is missing the () of dsa_port_parse_of()

> a network device but the subsequent call to dsa_port_parse_cpu()
> fails, dsa_port_parse_of() returns without releasing the reference
> count on the network device.
> 
> of_find_net_device_by_node() increments the reference count of the
> returned structure, which should be balanced with a corresponding
> put_device() when the reference is no longer needed.
> 
> Found by code review.

I agree with the reference not being properly released on failure,
but I don't think this fix is complete.

I was trying to figure out where the put_device() would happen in
the success case (or on removal), and I failed to find it.

Also if the (indirect) top caller of dsa_port_parse_of(),
dsa_switch_probe(), fails at a later place the reference won't be
released either.

The only explicit put_device() that happens is in
dsa_dev_to_net_device(), which seems to convert a device
reference to a netdev reference via dev_hold().

But the only caller of that, dsa_port_parse() immediately
calls dev_put() on it, essentially dropping all references, and
then continuing using it.

dsa_switch_shutdown() talks about dropping references taken via
netdev_upper_dev_link(), but AFAICT this happens only after
dsa_port_parse{,_of}() setup the conduit, so it looks like there
could be a window without any reference held onto the conduit.

So AFAICT the current state is:

dsa_port_parse_of() keeps the device reference.
dsa_port_parse() drops the device reference, and shortly has a
dev_hold(), but it does not extend beyond the function.

Therefore if my analysis is correct (which it may very well not
be), the correct fix(es) here could be:

dsa_port_parse{,_of}() should keep a reference via e.g. dev_hold()
on success to the conduit.

Or maybe they should unconditionally drop if *after* calling
dsa_port_parse_cpu(), and dsa_port_parse_cpu() should take one
when assigning dsa_port::conduit.

Regardless, the end result should be that there is a reference on
the conduit stored in dsa_port::conduit.

dsa_switch_release_ports() should drop the references, as this
seems to be called in all error paths of dsa_port_parse{,of} as
well by dsa_switch_remove().

And maybe dsa_switch_shutdown() then also needs to drop the
reference? Though it may need to then retake the reference on
resume, and I don't know where that exactly should happen. Maybe
it should also lookup the conduit(s) again to be correct.

But here I'm more doing educated guesses then actually knowing
what's correct.

The alternative/quick "fix" would be to just drop the
reference unconditionally, which would align the behaviour
to that of dsa_port_parse(). Not sure if it should mirror the
dev_hold() / dev_put() spiel as well.

Not that I think this would be the correct behaviour though.

Sorry for the lengthy review/train of thought.

Best regards,
Jonas

> 
> Cc: stable@vger.kernel.org
> Fixes: deff710703d8 ("net: dsa: Allow default tag protocol to be overridden from DT")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - simplified the patch as suggestions;
> - modified the Fixes tag as suggestions.
> ---
>  net/dsa/dsa.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index a20efabe778f..31b409a47491 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -1247,6 +1247,7 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
>  	struct device_node *ethernet = of_parse_phandle(dn, "ethernet", 0);
>  	const char *name = of_get_property(dn, "label", NULL);
>  	bool link = of_property_read_bool(dn, "link");
> +	int err = 0;
>  
>  	dp->dn = dn;
>  
> @@ -1260,7 +1261,11 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
>  			return -EPROBE_DEFER;
>  
>  		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
> -		return dsa_port_parse_cpu(dp, conduit, user_protocol);
> +		err = dsa_port_parse_cpu(dp, conduit, user_protocol);
> +		if (err)
> +			put_device(conduit);
> +
> +		return err;
>  	}
>  
>  	if (link)


