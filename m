Return-Path: <stable+bounces-240429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEMfBS3E6WkAjwIAu9opvQ
	(envelope-from <stable+bounces-240429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:03:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5404644DCEF
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942FF30210D6
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BA93DC4A6;
	Thu, 23 Apr 2026 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCDVaaI7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13D3D348E
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927734; cv=none; b=fzYoy7VAxH5K4s1LtaNzol1b90d3g2WPLIciwfnV/CAFN/DO3oEpx/ejfemyKVQbE1a9mqsIYhWvQ0Gl2yZQunKOJgZD7f8UoikhlWeTpsVFC6x/CVilHJILzu68AVJr5A9k9tkkZZmfXEvHPbOSuzw4VNjeStNziADYy288Xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927734; c=relaxed/simple;
	bh=Lwst00UY6fYep2Cx6uGiNQohWQe/DKSHTzjD5zgjIqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TumPFIzcJLK4BBxG59FnzP+9AhfnVfQelB9OK2uHse/ryxfIMQq7I1eiNgbOLVPFvNSfTzILy/DJDbI8HwsnzcjF6qpTvEuKMY87FQh7tFEo+p/2rKIOKg1nnYXsJwJQ3RFSQm0Jf/hUnikdaiY6RmmF37SiDMSC28CNVO6E5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCDVaaI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE1C2BCAF;
	Thu, 23 Apr 2026 07:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776927734;
	bh=Lwst00UY6fYep2Cx6uGiNQohWQe/DKSHTzjD5zgjIqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jCDVaaI7bO9BGKNJ3Ymf3X8lAB45v6tFQPFmwNd8ynxjo8HBIB0249E1SZSr+UvWH
	 2LyjPzccAeorsNGyBO8n0TYDKvLAN4m6RBYdn7WMCUVy/xwZP8UWlVY0QlkYbwj2Ai
	 NqaJn2RCixOMbzyXxHnfMl9WCqnXwGMKOmp1sfvYjf5iuZGN9Zv1CYAf7KZBNMykwe
	 EoblSSU1509UDmwVkG5mbMBjRW84dhoC3Vuiunnh9UxgYzE4qaLw+R8Aesxy+B+xZS
	 XxndOU9osUkkr0gwQMVpKhLbckyAIuxQX25gZhLqJ7H2f1AmJWTwbFs1JT82Dl7v60
	 +VB45EEttR5NA==
Message-ID: <1ee4f907-1eca-473d-93b2-c99d733a432b@kernel.org>
Date: Thu, 23 Apr 2026 09:02:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Backport request
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Josh Law <joshlaw48@gmail.com>, stable@vger.kernel.org
References: <C9577A36-B531-4480-BEA5-42F660C184CA@gmail.com>
 <2026042325-backhand-vanish-f69d@gregkh>
 <fc6ea52a-320a-4821-972c-3376e687fecf@kernel.org>
 <2026042320-husband-brought-c7c7@gregkh>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <2026042320-husband-brought-c7c7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240429-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5404644DCEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/04/2026 08:46, Greg KH wrote:
> On Thu, Apr 23, 2026 at 08:39:29AM +0200, Krzysztof Kozlowski wrote:
>> On 23/04/2026 06:55, Greg KH wrote:
>>> On Wed, Apr 22, 2026 at 06:04:50PM +0100, Josh Law wrote:
>>>> Hello, I would like backports for 
>>>>
>>>> Mainline hashes:
>>>>
>>>> https://github.com/torvalds/linux/commit/8cdf30813ea8ce881cecc08664144416dbdb3e16
>>>>
>>>> https://github.com/torvalds/linux/commit/9003ec6f7f394943880618737d797a9f257e6e1e
>>>
>>> None of those have showed up in an actual release yet, so why should
>>> they be included "early"?
>>
>> None of the code was tested as Josh Law lied more than once about tests
>> [1] or laughed at us when we asked for testing:
>>
>> "laugh my ass out and your test cases, absolutely ill add some test
>> cases" [2]
>>
>> and then Josh Law was pushing his patches to get merged:
>>
>> "This most definitely needs to be merged." [3]
>> "Yeah in my opinion I think this may need to be merged.. if you would
>> like I can add the NOWARN" [4]
>>
>> And now we see a push for these commits to stable!
>>
>> Nothing from Josh Law should be going to stable trees, because nothing
>> was ever tested.
> 
> Makes sense, is anyone going to send reverts for these?

Untested does not mean yet incorrect, so not sure if we need to act on
already accepted commits getting to stable. Especially that for a revert
I would need to provide some stronger arguments, IMO. Easier to drop
from the queue in review.

OTOH, if the actor is not trusted, a past correct patch is not a
positive indication for another patch. Untrusted, for whatever reason,
actor can write correct patches for some time...

When untrusted person pushes why things are not in stable, it feels to
me like a warning sign.

> 
> I'll drop them from my "to review" stable queues, that includes the
> following:
> 
> 	 mm/damon/sysfs: check contexts->nr in repeat_call_fn
> 	 mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
> 	 mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
> 	 lib/ts_bm: fix integer overflow in pattern length calculation
> 	 lib/ts_kmp: fix integer overflow in pattern length calculation


Best regards,
Krzysztof

