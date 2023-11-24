Return-Path: <stable+bounces-297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1767F775B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0499C2820BA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06002E640;
	Fri, 24 Nov 2023 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="WVBN5wQK"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02152199B
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 07:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700838626; x=1701443426; i=deller@gmx.de;
	bh=8Kmf5uBAWIDxMMfhkW72GEOQ1+8AdoFGH4sbK8KFcOo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=WVBN5wQK36wEN94cbpfVVebNPspIYljichavGgWsQWaACEzag5yQtVP2xLeDfAS3
	 CCaImH2kbWw1iHcPHXg9wH1j2bgpysaT0tZj9XcFH67AXyL+JMvlDyqsb5EZd6YeR
	 yfQYdO2/gM3DpDmCnIHmfVboy+eRVY19qNnKrRL7PMlEx7ZDd3HW2UD3MF99EW7cD
	 jL9pfg0mpqgNTBGc3UD37l6pLCzBneH+IOCIUGJGhYQW62UadQE1eFvGgV8U9OZP+
	 9zcTv+zO/r4YQKLtXTg+0Osd5Z+tUCExzxqIQfqZPNZE7svyTzI7t7F8tpF0b5yMM
	 ayONEqOz9uNmGf6rNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.145.42]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1rJceo2xns-0148T5; Fri, 24
 Nov 2023 16:10:26 +0100
Message-ID: <1aadb9ed-5118-4a6f-a273-495466f4737b@gmx.de>
Date: Fri, 24 Nov 2023 16:10:25 +0100
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
To: gregkh@linuxfoundation.org, sam@gentoo.org, stable@vger.kernel.org,
 torvalds@linux-foundation.org, Florent Revest <revest@chromium.org>,
 Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>
References: <2023112456-linked-nape-bf19@gregkh>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2023112456-linked-nape-bf19@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g8tWRVagT+g9UG14/D2S4o53jgPpz11nD3fi0k4qIO+objVr9x0
 2qRwzpt01Y0HxYDNGvwieSDqAWGTGrEfIllZKG8RyttZkd8nuRMz9LuSiCHr6nlWwv69SYa
 pD2/Enw4/+pxoZ76Y3+8l75uUHMtCYZ7hgIQ1MJ2tIZtEnmTNI7CZuMRgu9PSXRVoWOb6eF
 ySSNumIiUsynI3ocua11Q==
UI-OutboundReport: notjunk:1;M01:P0:EsbA894O/lw=;687IhTpdXKPq8weOSgQ7mIErQ77
 mb8jyj+EOMWyxc4HRORG/VMM+ZMWumQdPPj5jzhixPSU6Wn6APF4DJP+UlrgmbF9wkRzI7xDC
 3zHnM4x874glR2ceP3Q03WHubfH0xYrnSbLlCpC//T0W5qqWH62+Br/ZcgUmzyzsMaohTLP58
 wr7Nkw2K+ELOqQhyYAAlZtrQp7I1sK9kHHqKcRy6N4ScFtKNFSYSLUE/B2jSp0F8qRJt6CYZd
 GCVIHiEuq4HYN4+Je4jrjUQNIyj6AJ/R5623ZQGxuOeJwo/mVuz/mWfXUFu14hr5tustrEvHi
 PLWRs+iPW4tLI4zLqq8gXZlf/eHbime3xcRqUruGIazXmEVHXgg+9dnTUVf3kVUdItOG+5ghz
 +9IdNPqdCGk1+c1oTQ85f8EvfkvxFXcplQVuaDoy/PljSDxMpcssAgiK3ERO9D4YOGHL1OKwh
 aPAbtzd5KhH8/leZJ4WGGd7Ho0I7++2yJsjseX+yBWmY0xu0DxzOf8uHTLb8PhEZDe8n2WSrJ
 ci6JlQQrktMsTspSm8Av3hs+FodKaL5+6lr969qUDN/uxxD3cvh76llmUyJLj+VV1zhjQ2fCT
 IfeIZQBxmsGnL7GZ6ZCAhiQCxSivNEbZ6ETv4YUmzPHzTscH4tb9dzP+ftYVQWP7c5h+CU/db
 K0zsb8LeYVQLuFwq9TseOb5K2L65RPHnXVbqg3tONqFAKXN5JcI/4ZSheTAtZrbaAOBxItXv+
 LzTzUBR1Z5Ln+R1hEtLx+DTrn9FTyY+rTgUL8bHanOKJHcN0yahwOTxWV7myrlnhpa0+4mP7u
 bim403sWwO7PHSP9gYfhyP9TsZ/vmZy52/nD69Lj4WdJEINcumj0KO3bk4ZMEh6p8czUjDS/+
 SLbae1jSkdT59LSZgcPtpqk1W53YJnq9i+64IRNDCf52ClXdV0T4E8T68OHkhrqw+Y4QWcV3O
 FoDoVXf9m1835s7VBR0dCf9EJic=

On 11/24/23 12:35, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.5-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following comman=
ds:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.g=
it/ linux-6.5.y
> git checkout FETCH_HEAD
> git cherry-pick -x 793838138c157d4c49f4fb744b170747e3dabf58
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112456=
-linked-nape-bf19@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
>
> Possible dependencies:
>
> 793838138c15 ("prctl: Disable prctl(PR_SET_MDWE) on parisc")
> 24e41bf8a6b4 ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl")
> 0da668333fb0 ("mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long")

Greg, I think the most clean solution is that you pull in this patch:

commit 24e41bf8a6b424c76c5902fb999e9eca61bdf83d
Author: Florent Revest <revest@chromium.org>
Date:   Mon Aug 28 17:08:57 2023 +0200
     mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl

as well into 6.5-stable and 6.6-stable prior to applying my patch.

Florent, Kees and Catalin, do you see any issues if this patch
("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl") is backported
to 6.5 and 6.6 too?
If yes, I'm happy to just send the trivial backport of my patch below...

Helge


> ------------------ original commit in Linus's tree ------------------
>
>  From 793838138c157d4c49f4fb744b170747e3dabf58 Mon Sep 17 00:00:00 2001
> From: Helge Deller <deller@gmx.de>
> Date: Sat, 18 Nov 2023 19:33:35 +0100
> Subject: [PATCH] prctl: Disable prctl(PR_SET_MDWE) on parisc
>
> systemd-254 tries to use prctl(PR_SET_MDWE) for it's MemoryDenyWriteExec=
ute
> functionality, but fails on parisc which still needs executable stacks i=
n
> certain combinations of gcc/glibc/kernel.
>
> Disable prctl(PR_SET_MDWE) by returning -EINVAL for now on parisc, until
> userspace has catched up.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Sam James <sam@gentoo.org>
> Closes: https://github.com/systemd/systemd/issues/29775
> Tested-by: Sam James <sam@gentoo.org>
> Link: https://lore.kernel.org/all/875y2jro9a.fsf@gentoo.org/
> Cc: <stable@vger.kernel.org> # v6.3+
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 420d9cb9cc8e..e219fcfa112d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2394,6 +2394,10 @@ static inline int prctl_set_mdwe(unsigned long bi=
ts, unsigned long arg3,
>   	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
>   		return -EINVAL;
>
> +	/* PARISC cannot allow mdwe as it needs writable stacks */
> +	if (IS_ENABLED(CONFIG_PARISC))
> +		return -EINVAL;
> +
>   	current_bits =3D get_current_mdwe();
>   	if (current_bits && current_bits !=3D bits)
>   		return -EPERM; /* Cannot unset the flags */
>


