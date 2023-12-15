Return-Path: <stable+bounces-6794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 672DA8144BB
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C68A1F23597
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B4418654;
	Fri, 15 Dec 2023 09:38:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4796F18AE1;
	Fri, 15 Dec 2023 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rE4ec-0006LH-4f; Fri, 15 Dec 2023 10:38:46 +0100
Message-ID: <7766d1f5-103a-4a46-b95b-2e27dc63644f@leemhuis.info>
Date: Fri, 15 Dec 2023 10:38:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] vsocket timeout with kata containers agent 3.2.0 and
 kernel 6.1.63
Content-Language: en-US, de-DE
To: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
References: <CACW2H-4FpZAizkp+U1aS94V_ODn8NUd1ta27BAz_zh0wo63_rQ@mail.gmail.com>
 <CAGxU2F6C8oUY4B38y17Ti9u9QdYqQKamM+S2nofjYe5b9L1tBQ@mail.gmail.com>
 <CACW2H-7xr8-kDWJ9xqzx7c1Ud3QhqL2w+BGYpjOEdnkj9_Kzhg@mail.gmail.com>
 <CAGxU2F5=fTNQVf7gkmLGTeRe825H6tw_vi_uuUiX-hXyRR=1nQ@mail.gmail.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAGxU2F5=fTNQVf7gkmLGTeRe825H6tw_vi_uuUiX-hXyRR=1nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702633128;56993870;
X-HE-SMSGID: 1rE4ec-0006LH-4f

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 11.12.23 16:23, Stefano Garzarella wrote:
> On Mon, Dec 11, 2023 at 3:20 PM Simon Kaegi <simon.kaegi@gmail.com> wrote:
>> Thanks Greg, Stefano,
>>
>> tldr; withdrawing the regression -- rust-vmm vsock mistake

In that case:

#regzbot resolve: reporter withdrawed the report
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

>> Thanks all... nothing to see.
>> - Simon
>>
>> On Mon, Dec 11, 2023 at 3:39 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>
>>> On Mon, Dec 11, 2023 at 5:05 AM Simon Kaegi <simon.kaegi@gmail.com> wrote:
>>>>
>>>> #regzbot introduced v6.1.62..v6.1.63
>>>> #regzbot introduced: baddcc2c71572968cdaeee1c4ab3dc0ad90fa765
>>>>
>>>> We hit this regression when updating our guest vm kernel from 6.1.62 to
>>>> 6.1.63 -- bisecting, this problem was introduced
>>>> in baddcc2c71572968cdaeee1c4ab3dc0ad90fa765 -- virtio/vsock: replace
>>>> virtio_vsock_pkt with sk_buff --
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.63&id=baddcc2c71572968cdaeee1c4ab3dc0ad90fa765
>>>>
>>>> We're getting a timeout when trying to connect to the vsocket in the
>>>> guest VM when launching a kata containers 3.2.0 agent. We haven't done
>>>> much more to understand the problem at this point.
>>>
>>> It looks like the same issue described here:
>>> https://github.com/rust-vmm/vm-virtio/issues/204
>>>
>>> In summary that patch also contains a performance improvement, because
>>> by switching to sk_buffs, we can use only one descriptor for the whole
>>> packet (header + payload), whereas before we used two for each packet.
>>> Some devices (e.g. rust-vmm's vsock) mistakenly always expect 2
>>> descriptors, but this is a violation of the VIRTIO specification.
>>>
>>> Which device are you using?
>>>
>>> Can you confirm that your device conforms to the specification?
>>>
>>> Stefano
>>>
>>>>
>>>> We can reproduce 100% of the time but don't currently have a simple
>>>> reproducer as the problem was found in our build service which uses
>>>> kata-containers (with cloud-hypervisor).
>>>>
>>>> We have not checked the mainline as we currently are tied to 6.1.x.
>>>>
>>>> -Simon
>>>>
>>>
>>
> 
> 
> 

