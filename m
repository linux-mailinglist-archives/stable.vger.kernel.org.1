Return-Path: <stable+bounces-242241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIDvOHpR9GmKAgIAu9opvQ
	(envelope-from <stable+bounces-242241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 09:08:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416594AAC99
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 09:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D42300F9E3
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A93612EE;
	Fri,  1 May 2026 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXTou/N1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D63612ED
	for <stable@vger.kernel.org>; Fri,  1 May 2026 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777619314; cv=pass; b=hWZRixi90KNzWVTf1CH35WJhlqhwDaGp/XS95r1cab7iRPO5lKq7bLiZYqJzjyok3Mv165mITj5cWVmwuA4w28MgZBl9tMoaKywK3Jn/4NlclwqkL6b4ObkOXoyxEBPs1GMYbRCXHqzVjKRq2dyFjUm81MKGF4oh3JVzUsJ5Ykw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777619314; c=relaxed/simple;
	bh=/2lPvMgBwRlXYz+hwNAd2sawmW+FBi4qQaQzXa4mF5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doDnkZCfIi4ksD4HcONL7akehb6Md7cafP7U6nNUlnHBhywZeP9uiZbJvGH/zPL7peLJBnQplC1lWswtivi7HkFSVAqUeY8ZUoQT/K6yaxB+Tr+aeKE8lzJ1VMXkJyluf6BjgW4SVuY+xmZiYvsX9UToiPaic95mcA6REZTo0qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXTou/N1; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de44ed7a11so1489217a34.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 00:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777619312; cv=none;
        d=google.com; s=arc-20240605;
        b=FQzO0ocxfPxLwWMesjPEhT1CGgnXtshg+aBWUrC3MkrfBM7QZXZFKUGT0O+0Rvp5wJ
         F0uIgKASe+ZirtgNbjdzg7Id1ipUyDNX9m6QfyxCwXEEf6aOFJ7SaHFBNbnqS/KiOnpX
         COK6sBQIhn1Vj7RjN2uigVcNs1kTuYSuK1fbZ8LyH6HGNh7R2krYXFEsKvdU2cT0NaI6
         /OXvH9JcPWk4Y4z0edHN+zMs+/EBgZzStqURWTFtsNOg4a6rc4IzZoXauAkq6CU0PWOb
         xPpkXrVX94XuiHvxiN/RBxPr/B1sa05T8uFcelnTtzVC6x14xe3r/kiKrB89d95jmbok
         W1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tGtVcTIpMWEwpucmYm7Gx7tK/7UnKyIDFZfgCJLjmmw=;
        fh=yr0+R6/ThPoRrc7WFvW2hkm3k8WAjfbM3N4JwH52zo0=;
        b=a+frgsDSkJIRrpLtKa8IPCzCk3DL9Rb9gliakWnzOt2s25KsS5rc900/l6D0T/cV0Q
         cD9//XjruuUl3uTxuFLVuXmHkr7RE8+7SEFCgK5TBgyO1LFls6KDnK8QEjcgF3Lg8hXH
         jQkwxAZiwBqpx5IPBRKp7XbYORgfej8Fcg60aZr9kiWfnQYYDqUFBt0x/5q7wsLFMwc3
         SgWqBdDLdYBmuFHwUyGYG2BiiK8L6ct1Tw++cr2qul6TC2I/bDqoIcwoRnGy9npvwQkN
         FLmwON17rKk+e9wJdWQXZ9c+eqC9lGMiro8rIfeX2opN9s5FnGdUlKgwhOvqVRuF1rBf
         CPjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777619312; x=1778224112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGtVcTIpMWEwpucmYm7Gx7tK/7UnKyIDFZfgCJLjmmw=;
        b=cXTou/N1+kS9GIoVx1HqLcqUjD3JRvLuk2U20KpVJzepXqWsjhNbObYaPUerntmAkA
         hLKC7yfpZcpTeKlWAnuPNwldnVlLzB2rLc6RLDJKaOj6oCy7SDyoao5AXWR40J24VUIN
         Z63R4dLIc+kF9oJg8cg9fjXlFbv3AUVOMbRxUAgulD5igZKFZItYpo8eS3kt2NexIcbQ
         dSVKBCjLUvaEjksY6/cJrnRdFSsgKl22RM78y2IQufQcibQfYIGHqqeyWiRnuKgfptJ6
         20fEd+LYPTTkJ3wLe0FytePCUGQhqe8fSBZjfBmFJTEdsyCnPCzbKoOoGYUIrVerzlMU
         99iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777619312; x=1778224112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGtVcTIpMWEwpucmYm7Gx7tK/7UnKyIDFZfgCJLjmmw=;
        b=AkUQD2+3QVRBtNG/SZPrCPloZiGoFaeqYoB+SOEJyuk90Ud5B2uywra/v+JhrnTJD6
         bIMgy71BJaUeYeQ8qcKYPvMn0wFhORjCS7k1+kh1/6hJYz/dlibubMAs73lsb/AEmtUP
         shBu1TWNqu1RkD62GTLrUCHSvpS7GXGi7al88vO5IhWvAMh7KQ3H8dr94lYw676umv+i
         fMwvP8lEUxox4/X/swY+vySDvrlY0D0m+Vfa+GTLiZvkeMhonm69JvoQqCHdQYt0HdTC
         yjKExr+poLNcNiPMogMnxrLeMkxYpbvsZGWucl/sPg8lpi2oQe8VfjnyJzGSqFBVub+e
         cgCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/axTZ66iBvQzzk5zFP2xSxlpZHYKXX+cKL3ZJ08GchIwgnVqRltb0A7SJoI/eyhQNwj67g1EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTlmpg3dOQZbYcu2q9n7U738LdHxBhaaq//CSuD8IEnNA6+kL
	bfyHPrsXInh6zmSLTdi/6tZShrV7J8uWA/Lf+pj+49wuqBEXe5Uk6b4C+MBLpnwOa1RsYIlCx3M
	J6d3T8Blj1uougugkLiI0PUCikPNau886qFMiuxo=
X-Gm-Gg: AeBDievMUhCUQSihcG7GPA8LLq0xfYhTu0ihY++crRq6GbAZOoEZx6YwAkodnnWwIL9
	lzwXCXJ1QS/1hai/n9ooUm4NBcMcE0LaH+TlHvR57jdIrFgXmIfooR7UFaweBDlQbzH0Oh/MnrU
	W6PUX21GJQ/FNFVg4sMtLRbo+LOXckxpGWtWWr7+swXsn8U1CL/8ARpu1+LdtdKTSNafszUTuhj
	ekT2l2/28mpTdV4EaGGFh2OrMnnzCUr9/m6qSSB6FCiMgHJekLsmrhHlHP2rtnhBkNx/3PjOvCr
	Oshulp1VnXvKw650aOrBCclT21GWKlnLYvynWr/KBJHgpI0=
X-Received: by 2002:a05:6830:2650:b0:7dc:c926:4f87 with SMTP id
 46e09a7af769-7debdde82d2mr3374302a34.16.1777619311744; Fri, 01 May 2026
 00:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
 <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com> <CAOPSVF0VHR4BQsmfWFeFnANsQYBw-x7fHxH2JFNO=oWjgeS66Q@mail.gmail.com>
 <ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@oss.qualcomm.com>
In-Reply-To: <ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@oss.qualcomm.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Fri, 1 May 2026 00:08:19 -0700
X-Gm-Features: AVHnY4ICkNhQPdf3q3XMOiB8IYKOepiuhb0qIQbdpuz7l3PNcE3h0yiAcsn0i0o
Message-ID: <CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 416594AAC99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242241-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]

On Mon, Apr 13, 2026 at 11:43=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 4/1/2026 11:48 AM, Kyle Farnung wrote:
> > On Tue, Mar 31, 2026 at 7:08=E2=80=AFPM Baochen Qiang
> > <baochen.qiang@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 3/31/2026 2:32 PM, Kyle Farnung via B4 Relay wrote:
> >>> From: Kyle Farnung <kfarnung@gmail.com>
> >>>
> >>> Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
> >>> reliability issues similar to those reported in [1]. These platforms
> >>
> >> how similar it is? can you describe the issue in details?
> >
> > The issue is that intermittently after suspend my WiFi adapter connects
> > successfully for a few minutes and then drops. It will then keep trying=
 to
> > reconnect in a loop but never succeed. A reboot will fix it, but eventu=
ally
> > I found that reloading the module also resolves the issue
> > (modprobe -r ath11k_pci && modprobe ath11k_pci). Based on some searchin=
g, I
> > did try adding "ath11k_pci.disable_idle_ps=3D1" to my kernel arguments.=
 At
> > first it looked like maybe it worked, but then I hit the same problem
> > again. At that point I decided to try building a custom module with the
> > ATH11K_PM_WOW override and so far I'm two days and 10 suspends in witho=
ut
> > issue.
> >
> > Looking through kernel logs, the issue appears to have started with ker=
nel
> > version 6.17.4. It looks like my Fedora install jumped from 6.16.10 to
> > 6.17.4 on October 22, 2025 and I started seeing the issue two days late=
r.
> >
> > Here are the logs from the most recent occurrence (filtered for brevity=
):
> >
> > Mar 29 15:26:24 kjfp14sg5 kernel: PM: suspend exit
> > Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: chip_id
> > 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> > Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: fw_version
> > 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id
> > WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> > Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
> > Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
> > Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
> > Mar 29 15:26:35 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-CONNECTED - Connection to 68:d7:9a:2a:94:f8 completed [id=3D=
0
> > id_str=3D]
> > Mar 29 15:26:49 kjfp14sg5 wpa_supplicant[2373]: wlp2s0: CTRL-EVENT-BEAC=
ON-LOSS
>
> this is the reason to your disconnection
>
> > Mar 29 15:26:55 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: failed to
> > flush transmit queue, data pkts pending 9
> > Mar 29 15:26:55 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-DISCONNECTED bssid=3D68:d7:9a:2a:94:f8 reason=3D4
> > locally_generated=3D1
> > Mar 29 15:27:00 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-DISCONNECTED bssid=3D80:2a:a8:98:26:3e reason=3D6
> > Mar 29 15:27:05 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-DISCONNECTED bssid=3D74:ac:b9:df:54:36 reason=3D6
> > Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-DISCONNECTED bssid=3D68:d7:9a:2a:94:f8 reason=3D2
> > Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"Batman" auth_failures=3D1
> > duration=3D10 reason=3DCONN_FAILED
>
> and the bssid is disabled so association to this AP won't happen in a per=
iod.
>
> Anyway, although it works, using the PM quirk seems not the right fix. As=
 you mentioned it
> seems like a regression starting to show in 6.17.4, can you do regression=
 test to locate
> the issue commit?

It took a bit of trial and error, but I'm reasonably confident that [3] is
the culprit. The issue is pretty sporadic, but I've been able to reproduce
it twice in ~50 sleep/wake cycles on that commit, while the immediate
ancestor has been clean for 17 cycles so far. I'll continue testing and
report back.

The change looks suspicious as it modifies a code path that runs on every
sleep/wake cycle, and the failure appears to be some sort of corrupted
firmware state. In a couple of cases the WiFi firmware crashed outright
(MHI_CB_EE_RDDM) while the issue was occurring.

[3] 79266fd78df1 ("wifi: ath11k: HAL SRNG: don't deinitialize and
re-initialize again")

>
> >
> >>
> >>> were not previously included in the ath11k PM quirk table.
> >>>
> >>> Add DMI matches for product IDs 21ME and 21MF to apply the existing
> >>> ATH11K_PM_WOW override, improving suspend/resume behavior on these
> >>> systems.
> >>>
> >>> Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
> >>>
> >>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> >>> [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/=
thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
> >>>
> >>> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on mach=
ine model")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>> - Fix missing mailing list recipients (linux-wireless, ath11k, linux-=
kernel)
> >>> - Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-c=
f2fa39cc2d5@gmail.com
> >>> ---
> >>>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wir=
eless/ath/ath11k/core.c
> >>> index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6=
cb9c93d9ef692d127fe 100644
> >>> --- a/drivers/net/wireless/ath/ath11k/core.c
> >>> +++ b/drivers/net/wireless/ath/ath11k/core.c
> >>> @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_qu=
irk_table[] =3D {
> >>>                       DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
> >>>               },
> >>>       },
> >>> +     {
> >>> +             .driver_data =3D (void *)ATH11K_PM_WOW,
> >>> +             .matches =3D { /* P14s G5 AMD #1 */
> >>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> >>> +             },
> >>> +     },
> >>> +     {
> >>> +             .driver_data =3D (void *)ATH11K_PM_WOW,
> >>> +             .matches =3D { /* P14s G5 AMD #2 */
> >>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> >>> +             },
> >>> +     },
> >>>       {}
> >>>  };
> >>>
> >>>
> >>> ---
> >>> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> >>> change-id: 20260330-p14s-pm-quirk-0a51ba19235f
> >>>
> >>> Best regards,
> >>
>

