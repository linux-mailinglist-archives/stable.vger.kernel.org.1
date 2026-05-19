Return-Path: <stable+bounces-249480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIw/MFYNDGqJVAUAu9opvQ
	(envelope-from <stable+bounces-249480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:12:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC39C578BAE
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17FCD300D1C6
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B9A3BE642;
	Tue, 19 May 2026 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="hA4UQkaK"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F23BED2B;
	Tue, 19 May 2026 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174737; cv=none; b=tWC7W13kwaeHomgjjSk6tpED0CRmFr99kn9V0DGQMeerepUyZHOrsG9tPmDFk6fEHAeR0aeSeIe1Cc/yZkUV7NKGQoE6eUkw990+Y4QI/rpKzuQ+ZndP55rjbcgRQjUdGlNF9KPkq/jJOfNN6lX0HIXKOEmFyk7agaZjAy1cOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174737; c=relaxed/simple;
	bh=5uuP/FH+7GDJLdtTbgadOddQMZvKa2mSDX9isBHrM14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jo8aynmQzRhU6/6ow+OkcM2DxhEz7JiYe4ugQdmu0HyUHuM7xt+ai1zzpRJwnBZnsd5QJ1ePC4j23WjTMjFZxYeMEHSgfXOvvI+dBBeC2pwlz5s1ckWHxs8x3iseSQtNoO5j45ZxaYrmuHcB41LP7MmeV7KC1bW0g+t/P8KIGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=hA4UQkaK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779174681; x=1779779481; i=deller@gmx.de;
	bh=sjN4qrmiu1bglWGSsI9NyPKGX/0wNg2Vet3nC5b3oBo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hA4UQkaKAIiPJDkYM2tL0/HLJCM25X96CSFc6LWCjIgNvoNJpit9sfqO7DGTaqgz
	 VPW+/W1/keBz2jf/Reir08UUkX35nAlP1o814WPsn+dCnQG/z8QizN/tUEDpJV9tH
	 yDlTmCADfCV5NmKvdZdi9tgjKC/8Y0EpVHVJYpk4p2dC/IxEFYiGvhek2+iA7Irj2
	 Die54ZaYpe7omjxW2qhRhV2+Ivk1yfbxVXudq46424npyL0H7+I+HseC1AVlSls4i
	 zXEmsfzT1d3kvz+KW4EkWa8DB5VPs3fCkZJ6WLpUEBk60vfI9QqIwj/8WFLe+PrGV
	 y/dfzyQWZ0lDtMa8/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1xFPMC19m9-010KBI; Tue, 19
 May 2026 09:11:21 +0200
Message-ID: <6e6afdae-0da8-4665-a450-6431c3b3de2f@gmx.de>
Date: Tue, 19 May 2026 09:11:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] fbdev: fix various memory leaks
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Ondrej Zary <linux@rainbow-software.org>, Antonino Daplas
 <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>,
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>,
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I+nuZNHtkyT0KGRnNoW0hv+cck4+dSR0JeC+FXKXX/pnlOdWP3q
 zfPEipLnWcaRYk/86Hp0tWyLzCKdScumWP150LynM4yizZqneKU1PMh8nI/8HznSc/KnSTg
 sQLHsOZcmfgOy3/8RYfTFpYfx3MCYosU3kpq24v8wgDpCprqsm6oUKKG0xaSnHedDe8kKhe
 ihPEObBprZ3cU6eriduyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5w3QRt1/Z2c=;tHCPKBrlfEF0+EySYESy9S0Ppkv
 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
 /rzvAQ==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cse.iitm.ac.in,redhat.com,suse.de,kernel.crashing.org,linux-foundation.org,linutronix.de,gmx.de,rainbow-software.org,gmail.com,linux-sh.org,wp.pl,ti.com,gentoo.org,denx.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-249480-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:mid,gmx.de:dkim,iitm.ac.in:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AC39C578BAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/14/26 10:24, Abdun Nihaal wrote:
> This patchset fixes some memory leak issues present in fbdev drivers.
>=20
> Since commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref s=
truct")
> fb_deferred_io_init() allocated memory for pagerefs and returned an
> error code, but the existing drivers which call fb_deferred_io_init()
> were not updated to do cleanup. The first three commits address this.
> - fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
> - fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
> - fbdev: metronomefb: fix potential memory leak in metronomefb_probe()
>=20
> Probe functions that call fb_add_videomode() or fb_videomode_to_modelist=
()
> sometimes did not call fb_destry_modelist() to free the allocated
> memory. The following patches address this issue.
> - fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
> - fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
> - fbdev: i740fb: fix potential memory leak in i740fb_probe()
> - fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
> - fbdev: s3fb: fix potential memory leak in s3_pci_probe()
> - fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
> - fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
> - fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
>=20
> Since commit 73ce73c30ba9 ("fbdev: Transfer video=3D option strings to c=
aller; clarify ownership")
> the fb_get_options() function transfers ownership of the memory
> allocated for options, and so the caller is expected to free it. The
> following two patches address this issue.
> - fbdev: efifb: fix memory leak in efifb_probe()
> - fbdev: vesafb: fix memory leak in vesafb_probe()
>=20
> The following commit fixes a simple memory leak.
> - fbdev: sm501fb: fix potential memory leak in sm501fb_probe()
>=20
> All the patches were only compile tested.
> The issues were found using static analysis.
>=20
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Abdun Nihaal (14):
>        fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
>        fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_pr=
obe()
>        fbdev: metronomefb: fix potential memory leak in metronomefb_prob=
e()
>        fbdev: radeon: fix potential memory leak in radeonfb_pci_register=
()
>        fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
>        fbdev: i740fb: fix potential memory leak in i740fb_probe()
>        fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
>        fbdev: s3fb: fix potential memory leak in s3_pci_probe()
>        fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
>        fbdev: tridentfb: fix potential memory leak in trident_pci_probe(=
)
>        fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
>        fbdev: efifb: fix memory leak in efifb_probe()
>        fbdev: vesafb: fix memory leak in vesafb_probe()
>        fbdev: sm501fb: fix potential memory leak in sm501fb_probe()
>=20
>   drivers/video/fbdev/aty/radeon_base.c | 1 +
>   drivers/video/fbdev/broadsheetfb.c    | 8 ++++++--
>   drivers/video/fbdev/carminefb.c       | 1 +
>   drivers/video/fbdev/efifb.c           | 1 +
>   drivers/video/fbdev/hecubafb.c        | 6 +++++-
>   drivers/video/fbdev/i740fb.c          | 1 +
>   drivers/video/fbdev/metronomefb.c     | 8 ++++++--
>   drivers/video/fbdev/nvidia/nvidia.c   | 1 +
>   drivers/video/fbdev/s3fb.c            | 1 +
>   drivers/video/fbdev/sm501fb.c         | 3 +++
>   drivers/video/fbdev/tdfxfb.c          | 1 +
>   drivers/video/fbdev/tridentfb.c       | 1 +
>   drivers/video/fbdev/uvesafb.c         | 4 ++--
>   drivers/video/fbdev/vesafb.c          | 1 +
>   14 files changed, 31 insertions(+), 7 deletions(-)
I applied the whole series to the fbdev git tree.
Thanks a lot !

Helge

