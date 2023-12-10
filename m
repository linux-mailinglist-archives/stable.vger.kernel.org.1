Return-Path: <stable+bounces-5204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D3480BC3C
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 17:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569721F20F49
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEE91802A;
	Sun, 10 Dec 2023 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Z734Qfbx"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52013F5
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 08:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702226633; x=1702831433; i=deller@gmx.de;
	bh=urUdDJUQibL24diV9esAJ7S2KjaGePWL71SttQL6x9U=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Z734Qfbx4tsfCXhHe81tCGkZ+Jas6eQu7C+CKZ/4qpLBILoK4pjHv9SSV/EnV4i/
	 ZjURYzRoxGIjtf7Vn9FquwGc48pmJkYDgvlycD8Nc/iPxdp6ZvgOi5XiKDws0qRuE
	 p3lb4yKnQas3Di4Zjyxjb1yDIGV53ToCk8ZgJjaE+ZI4OEmSshYkiUxXAMVvgElkd
	 wz/nzawSpfXOW6K1dKELRHTpmzwI6dkCnEN43Vx3aI0VNrlUJrj3Ij5clDNaGJGXM
	 R4kUAETgQQPnBDej96pc3MmyvK9DYpOyjML8GI4ietsnkiUPPOlHRacQPOjT8li5m
	 FX/IH66wJTkIpb3NtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.151.132]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1qjOyG2Q4f-00XIma; Sun, 10
 Dec 2023 17:43:53 +0100
Message-ID: <c5d9b509-3c37-419b-a325-971d9b2c7c56@gmx.de>
Date: Sun, 10 Dec 2023 17:43:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] parisc: Fix asm operand number out of
 range build error in" failed to apply to 6.1-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, lkft@linaro.org
Cc: stable@vger.kernel.org
References: <2023120949-waged-entail-7b6b@gregkh>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2023120949-waged-entail-7b6b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cXLit3Ws/kCTv3jq3T1h8QMviRn7ieaOXCbyRxDvvfu8G2apcFo
 rzZGP+ffHG8/UBA6cbrtU3dqpLRwFE+MjyKv212WvPA7gF8zN5YR9h7DJXOYTnY0EEsuDcG
 Vxkvwc7s8Z5/UqkNlZsYu6Oi8cWIekLBZaJ0IxWgHK6xUGNGKTAAQqlRPqqgJ7GFzGIOs2m
 5oSNpbzb2UhNQMHa6wstA==
UI-OutboundReport: notjunk:1;M01:P0:QdYsJC0aQds=;lG8UTrIUXv0ifbG252l4gvoB6Qo
 P+eka64qU8PhoIVpgpNqwqGkZt9hvY5xDHCRcXEyG51fL12YXL1+odbSTU6+6tUoNVN7jaSdv
 0EPaWb8TM2hCPEvqv+mAh10j9Xg3cGEQV2kj6PaTjXTq6Hjp+G/HG4QkNMIV7M1/o/7buGdYm
 ZGK3Sm1U9gwfa7FykhicVGCVc0GybG4oQG6BbCXRWA+yxSnirLk2Lczf0f8+ZdWD7uGfzNTUN
 z6NQu+VidkRJUnDiYEHKuNQkt4i6cWUicWYQfkkAIIeIOk9WzCyzb5NinER7r8hZz2DL0B2yQ
 CNq/x9QpBICx1jev0nga6Xq/15TQMk5bJmJua8jNSVHC1rAPXtlJuVBS9WYht55moX01BouHB
 msz3gildshhsTrZyOVphJrFWgxUihzGaJloiDynI+d0ZPcZSzkNDXJtftnD+lBDSFC8wkRAJn
 u1MaGDgUFQ21Uc93O+CilW3apXCwSN/hisJnZZSpJumvyS2h9L78XpKDN6BD031/R8L8EG1GV
 I2DdesXYaoD2cYStouUwxtRAUM1O3GkHHS80q6QDa6wDiGllO3AOknIDQup9AybuU7smYkKre
 NKHlXoxBCR8FgjYoFFf9dqLFadjiAvCQaRCubXLY059bisxb0KYMrsOf5n2invlF9SD53rZBx
 Nf984bY6V4NKX/38B8f2s5V1BOrh6jTZ6MhUccNldOeCVauTxJ5WaVF2KShWQm2Cmo5Mn+GWr
 5WuBRFHQreN2/EJ3/INtG7l91MV0iSR1tF0LL/a2wxZI4byRQ+VJOyIe4dnBLg5HGAXesjuIC
 Kg3v6PH4xImyrbyqRF49Q7np4hw2AnLNbAoZewDCJFgsR4q5hfgYnwH5rGjaVOiDyElBOogMZ
 isaEMWJjUPUE/XkIWiLEs5dq01+UWwpM+kIpf4yfBpKZwfr43O4FHxgNf0UO8ST+/AA3I8I/c
 m+4UeqOkENMVzGF9GypiLv1ptPQ=

On 12/9/23 13:33, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Right, it does not apply, and does NOT need to be backported.

So, please just ignore/drop it for 6.1 and 6.6 stable series.

Thanks!
Helge

>
> To reproduce the conflict and resubmit, you may use the following comman=
ds:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.g=
it/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 487635756198cad563feb47539c6a37ea57f1dae
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120949=
-waged-entail-7b6b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
> Possible dependencies:
>
> 487635756198 ("parisc: Fix asm operand number out of range build error i=
n bug table")
> 43266838515d ("parisc: Reduce size of the bug_table on 64-bit kernel by =
half")
> fe76a1349f23 ("parisc: Use natural CPU alignment for bug_table")
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From 487635756198cad563feb47539c6a37ea57f1dae Mon Sep 17 00:00:00 2001
> From: Helge Deller <deller@gmx.de>
> Date: Mon, 27 Nov 2023 10:39:26 +0100
> Subject: [PATCH] parisc: Fix asm operand number out of range build error=
 in
>   bug table
>
> Build is broken if CONFIG_DEBUG_BUGVERBOSE=3Dn.
> Fix it be using the correct asm operand number.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: fe76a1349f23 ("parisc: Use natural CPU alignment for bug_table")
> Cc: stable@vger.kernel.org   # v6.0+
>
> diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug=
.h
> index 1641ff9a8b83..833555f74ffa 100644
> --- a/arch/parisc/include/asm/bug.h
> +++ b/arch/parisc/include/asm/bug.h
> @@ -71,7 +71,7 @@
>   		asm volatile("\n"					\
>   			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
>   			     "\t.pushsection __bug_table,\"a\"\n"	\
> -			     "\t.align %2\n"				\
> +			     "\t.align 4\n"				\
>   			     "2:\t" __BUG_REL(1b) "\n"			\
>   			     "\t.short %0\n"				\
>   			     "\t.blockz %1-4-2\n"			\
>


