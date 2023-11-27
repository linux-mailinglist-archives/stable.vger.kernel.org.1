Return-Path: <stable+bounces-2756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA167FA136
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C4C1C20DA2
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B32FE0C;
	Mon, 27 Nov 2023 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="QLeaBtlP"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC824DE
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1701092423; x=1701697223; i=deller@gmx.de;
	bh=dXr6/rCGnKWBJ/3pACyABFSL90KeU/6NphoFbHciCt0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QLeaBtlPsmwywO61Ba4EYfveyyINAIL29y7elfD+gYBl6GAh6a9jB5qb1DG0qOxv
	 uzN6BlZHGSE1XaVWkbHSZ7q5RgXiqbxBmi3elnmZKyZdodBG58gYp0e8gQr/wlzfb
	 UmWWm9ECX5HDue5py5Agc3Rger8px87DD4pj+7KFZSv0VHImp1EcLDRe5H6jxEa+1
	 3/jqhb92dSLQtSX7Rjl1P9HRXV15QiQoIJRX+WqREYgqUzD399eQpEVWB4hqlLNB0
	 J0ZrMMeOQed9GEce41gGWABFd+ZNnG+T+87OiRR5VPvLvZNw9Sdxp74noKVANjoZB
	 vbW0a/sSfzZ1yIQMEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.210]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1ri2820L53-00d2od; Mon, 27
 Nov 2023 14:40:23 +0100
Message-ID: <cd2c6f01-d5ee-41c7-a2c9-b86b34ac6a6c@gmx.de>
Date: Mon, 27 Nov 2023 14:40:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] prctl: Disable prctl(PR_SET_MDWE) on
 parisc" failed to apply to 6.5-stable tree
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: gregkh@linuxfoundation.org, sam@gentoo.org, stable@vger.kernel.org,
 torvalds@linux-foundation.org, Florent Revest <revest@chromium.org>,
 Kees Cook <keescook@chromium.org>
References: <2023112456-linked-nape-bf19@gregkh>
 <1aadb9ed-5118-4a6f-a273-495466f4737b@gmx.de> <ZWSEsrpogmi7LQa_@arm.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZWSEsrpogmi7LQa_@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ji9CtwHadJPoGsFTY1U+SRS7ArOZjrna/X9HDC5mw47E3O2x3Fn
 8h+12TI+U6u4TO6MT41TsOGub9MKOwHGFPY/ScyvF2BuBIH4wuW4We+JXHv/5OImaNruCCC
 +640JT7EQxsd9+nPuhHWtD4deMxFJKMPaGsYIVBti7KwissiBgcdCV3HQ8O0ZNuNMWGDAHO
 AN4SZzJy74aOE67n3qwfg==
UI-OutboundReport: notjunk:1;M01:P0:qWMymotLCQ8=;DoSIYsY8LYU63+pywkEQnP3uuTU
 pkXDhmHqp9oUXCtxowTbJIXd8ZgXZk2uHTnx824+EEB7S4Q3fdQzpIcUT06XWVN0OiGkXP3JJ
 ZoKRXNRKeEPG0tZOnUMItIZwheOZwjqrRUCLqT2QDnzlXsFpUlX8AuindqYdVDiSQXdiSN3UR
 Fa7XKHbeCdgb3BhiAq1YUGObKQaNFN5EXUmunKhOOWUR4ZGEFpEJHgCg+kBMzWZlvFNWNtLKU
 TLM9eKndFPDT4yFBcRm7RzRnBrhzjNiwvc0MNieuSSJY/iQTfnsVVIK2QnevhUrecpC5FAZL8
 jdtXOxT96CRY7Dw5X8IWJYdI326p5qGGBIszrZLYWgJChci8RJc3lPQucyosnX+6c3s2zuK2Z
 7HImvFFdg4xo5vtxXeKmd97eRWbfteBCVg/w5O36A74VJONxUdKalUpMp45ASHq/Y4pfTeueV
 RLXE/5hiG6Y72ESJVeakzifyBjIyfZQUVXosA3CTRQo3YIHx0uiCl9oFQjQcgGMfzv4Wa9R0a
 SYhaZgMkybn1NnqVbZb66beRjy38kT8edrjFbIArv4wsX3rL31J06GQeVyQsydh3epPS8crnZ
 9SWTmIqAZDbR/BNKJLB3VoG22PLRloE40sCjUOcS3Hctfdf98RrlZB3hQS11TfxCxhkz9fHx5
 apKgLv93BeqTDQY/JRyEMHAelj71nlQeY4LHAW6mpYJj/K4ui2h3/5BzrtXFFgFufszw07u63
 XYrklHYxREMi2VK8NNHh5+d89VqhTxJ4UD5CTf+K6/xwhchKesLt9da5VFeqm3pWDjqBNp2bm
 iVqYrhS59akgzbx79axg5MJ8KRBinEFUCUghLLsSBNql3wCxkAblIbPvCduzEFEHSeXHuWMpR
 Uw1hAobo+7fF3pFcxguKeEZNWAUz4I1QKuvTuMsmZVP71RBZXecFtyg8Od1BzgsSPSn3pi27t
 A2PqZHNyIko3RKa7aTfc6OFHCco=

On 11/27/23 12:59, Catalin Marinas wrote:
> On Fri, Nov 24, 2023 at 04:10:25PM +0100, Helge Deller wrote:
>> On 11/24/23 12:35, gregkh@linuxfoundation.org wrote:
>>> The patch below does not apply to the 6.5-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commi=
t
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following comm=
ands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
.git/ linux-6.5.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x 793838138c157d4c49f4fb744b170747e3dabf58
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20231124=
56-linked-nape-bf19@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
>>>
>>> Possible dependencies:
>>>
>>> 793838138c15 ("prctl: Disable prctl(PR_SET_MDWE) on parisc")
>>> 24e41bf8a6b4 ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl")
>>> 0da668333fb0 ("mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long")
>>
>> Greg, I think the most clean solution is that you pull in this patch:
>>
>> commit 24e41bf8a6b424c76c5902fb999e9eca61bdf83d
>> Author: Florent Revest <revest@chromium.org>
>> Date:   Mon Aug 28 17:08:57 2023 +0200
>>      mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl
>>
>> as well into 6.5-stable and 6.6-stable prior to applying my patch.
>>
>> Florent, Kees and Catalin, do you see any issues if this patch
>> ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl") is backported
>> to 6.5 and 6.6 too?
>> If yes, I'm happy to just send the trivial backport of my patch below..=
.
>
> TBH, given that the NO_INHERIT MDWE is a new feature and it took us a
> few rounds to define its semantics, I'd rather not back-port it unless
> someone has a strong need for it in 6.5 (not sure the stable rules even
> allow for this). The parisc patch is simple enough to be backported on
> its own.

Ok.

Thanks!
Helge


