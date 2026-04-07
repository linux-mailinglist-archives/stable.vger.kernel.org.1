Return-Path: <stable+bounces-233711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNpXBwdK1Wlg4QcAu9opvQ
	(envelope-from <stable+bounces-233711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 20:16:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E13B2DB0
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 232CC304854D
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964422BE03C;
	Tue,  7 Apr 2026 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="qoCboFho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oyLlmDXh"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98010F2;
	Tue,  7 Apr 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585773; cv=none; b=bY8IkBH1YSFCP14nkcR7uvmKpHGgbp7R8noTX1NwlX3AjCRB4+jcVH5yewogrQqHSY4eecYt/EiujYdMhKJeavsPQ2q49jnG5DJRDcWX3m1Hf9orf/Cfw4atNhC1lB/UbU0jqARUuJrom6WFxSOplb5np/P0jb5CK3/ioYakXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585773; c=relaxed/simple;
	bh=+6rOZ8TVbem9Jlhsmqeh/hIbDTtTmVLWdtBqANXvFjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgoHnC6D1C6nniiAtqt8EaAec6i+p7yCdPUvZsVHCBA8Bf/EiPFnT+esBYCl8NK61ZN2o6uzyorUVZWJ63yfe1tdZxIJoCtxpYQ9zrRO8qMLL7Yf5tCfNjlMGIEOJKMQ2ANq9SREPZQgoDFYnVTmgn6PPAJ601Jiqnotg/+EraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=qoCboFho; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oyLlmDXh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 800411400034;
	Tue,  7 Apr 2026 14:16:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 07 Apr 2026 14:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775585769;
	 x=1775672169; bh=dQm6z7f6ASrTfFmzqfBj+lCDd4lKJ0iBzg4xh57Zsvw=; b=
	qoCboFhoPSbbrL5PrJHkkQ0QTtIvC5erP8IN1/kFA5nydWdHEqbYz4ESxO9S1xhF
	X+DYBIUEycY5vFrhY/OllhNyOPZEllFhUSV8WDmGMYsY3S1PUct+YYFUS+tEtea3
	dLxH3AE0CRmgrmSDNQEgkrjAq0w50PG4kDiviO2TtI3LsKETjmmhjD4x3PPm10dA
	YoTb4wMRk8KLz9Ro3OHWXRf0EQDSgfrxjF4HQL/lC23khEEjVrSFJm/jpCiBWQkY
	pJF6HSBYdx5YX/2ph6UbZ+MsT0E0OVstRshzlfU9dqShYxS6gdt0P7eGV1zP8Gl1
	vZv6SrJhbUP53aCvoIk+EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775585769; x=
	1775672169; bh=dQm6z7f6ASrTfFmzqfBj+lCDd4lKJ0iBzg4xh57Zsvw=; b=o
	yLlmDXhiDlFxhEX8zMKRFHbCVKD6ImWX+1TDPNnlvwnruYhzPaLNqJMnSYh2qZ5Q
	tP28XS2QYGBt2IUJ1YmeZ0eYDIwSZkiTFZf26wxNoMtMMtTj5B7g7a/KWN6kF+7x
	cONfD/ABR/Fu0H+yWHQVdSPn4erxhak95iGoOocu0qXz0+o1HOwHGt/1TrCM/tyf
	iKC59Jm9ni+2tRztgtZEqipBnGzy/qMUL4i+8LkqmN6RmJEwA8t+8fKs+h1XiG/u
	Vh/Phi9SaY6j1drkTXzisRode5lChUOp9IvKlLLHAHlWiZxk0jFbchoEvXnyYPgc
	wwtnCkUYyDUZimmS4F6qA==
X-ME-Sender: <xms:6EnVacNhsj77xNJa01LxbWyb-lv_sz7D9IjuHaDXWp8_vFwZmXCB-Q>
    <xme:6EnVadqqMlJduwlbdHhLwYRdt3F_ZhQcG-HIHaiIyP8Ek1O9kBPHChB_jv9s2yHV8
    SgDkoyEu2w7TCcPx0P0Zn-8tPMg6vTvWYXqjx2LmLICWYne2RZY5A>
X-ME-Received: <xmr:6EnVaZ5Nyh6IMOzBYAMX-xdDk4_bzgBTZ03J_k1o9T9IztNfrqPFgK24TI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculddquddtmdenucfjughrpeffhffvve
    fukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomheptehlvgigucghihhllhhirghm
    shhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepgf
    ejhfejleekjeefudffleeiuefhkedvieeiffehtedvveeuueevtdefgedtveeknecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpnhhishhtrdhgohhvnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdho
    rhhgpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthhughhruhhlrdhkuhhkuhhlsegvshhtrdhtvggthhdprhgtphhtthhopehgrhgvghhk
    hheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehsrghshhgrlh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpd
    hrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoheplhhorhgvnhiiohdr
    shhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihho
    nhdrohhrgh
X-ME-Proxy: <xmx:6EnVafqbrwxPmz_K9KFA-Rf3hPh4554QqCfw-ZgTaSNFL4bitoIZGQ>
    <xmx:6EnVafIk_w0HD9Rh1xce5yK4fVUNQJ2AthlOe5Akjqmz60MgPLtzaQ>
    <xmx:6EnVaUi-Bn7Sp_w85zysHPy1oGtGeOEVIPOzj0lGPwIFN7I4F-Ei2A>
    <xmx:6EnVaQ906i3Bx-kZixtf6gcc97Ts5clWAECItTWdbcunkgN4-zPEsA>
    <xmx:6UnVaYYtmE4Hi9_16emLw8Sfi-4OM8dwVOQ04ls8_ig1BWlVWhaQnhVj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 14:16:07 -0400 (EDT)
Date: Tue, 7 Apr 2026 12:16:05 -0600
From: Alex Williamson <alex@shazbot.org>
To: tugrul.kukul@est.tech
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org,
 kevin.tian@intel.com, jgg@ziepe.ca, lorenzo.stoakes@oracle.com,
 david@redhat.com, akpm@linux-foundation.org, mike.kravetz@oracle.com,
 linmiaohe@huawei.com, yi.l.liu@intel.com, axelrasmussen@google.com,
 leah.rumancik@gmail.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.nystrom@est.tech, alex@shazbot.org
Subject: Re: [PATCH 6.6.y 0/4] Fix CVE-2024-27022: fork/hugetlb race with
 vfio prerequisites
Message-ID: <20260407121605.17eb56d1@shazbot.org>
In-Reply-To: <20260402161311.63484-1-tugrul.kukul@est.tech>
References: <20260402161311.63484-1-tugrul.kukul@est.tech>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,intel.com,ziepe.ca,oracle.com,redhat.com,linux-foundation.org,huawei.com,google.com,gmail.com,est.tech,shazbot.org];
	TAGGED_FROM(0.00)[bounces-233711-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nist.gov:url,messagingengine.com:dkim,est.tech:email]
X-Rspamd-Queue-Id: 6C1E13B2DB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 18:13:07 +0200
tugrul.kukul@est.tech wrote:

> From: Tugrul Kukul <tugrul.kukul@est.tech>
>=20
> This series fixes CVE-2024-27022 on 6.6 stable by first backporting the
> necessary vfio refactoring, then applying the fork fix.
>=20
> =3D=3D Background =3D=3D
>=20
> CVE-2024-27022 is a race condition in dup_mmap() during fork() where a
> file-backed VMA becomes visible through the i_mmap tree before it is
> fully initialized. A concurrent hugetlbfs operation (fallocate/punch_hole)
> can access the VMA with a NULL or inconsistent vma_lock, causing a kernel
> deadlock or WARNING.
>=20
> The mainline fix (35e351780fa9, v6.9-rc5) defers linking the file VMA
> into the i_mmap tree until the VMA is fully initialized.
>=20
> =3D=3D Why this hasn't been fixed in 6.6 until now =3D=3D
>=20
> This CVE has had a troubled backport history on 6.6 stable:
>=20
> 1. cec11fa2eb51 - Incomplete backport to 6.6, only moved
>    hugetlb_dup_vma_private() and vm_ops->open() but left
>    vma_iter_bulk_store() and mm->map_count++ in place.
>    Caused xfstests failures.
>=20
> 2. dd782da47076 - Sam James reverted the incomplete backport. [1]
>=20
> 3. Leah Rumancik attempted a correct backport but discovered it
>    introduced a vfio-pci ordering issue: vm_ops->open() being called
>    before copy_page_range() breaks vfio-pci's zap-then-fault mechanism.
>    Leah withdrew the patch. [2]
>=20
> 4. Axel Rasmussen backported Alex Williamson's 3 vfio refactor
>    commits to both 6.9 and 6.6 stable [3][4]. The 6.9 backport was
>    accepted [5], but for 6.6 Alex Williamson pointed out that the
>    fork fix was still reverted =E2=80=94 without it, the vfio patches alo=
ne
>    are unnecessary. Axel withdrew the 6.6 series.
>=20
> 5. 6.6 stable has remained unfixed since July 2024.
>=20
> =3D=3D This series =3D=3D
>=20
> This series picks up Axel's withdrawn 6.6 backport of the vfio
> refactor patches [4] and adds the missing fork fix on top, completing
> the work that was left unfinished. Patches 1-3 are Alex Williamson's
> vfio refactor (backported by Axel Rasmussen), patch 4 is the CVE fix
> adapted for 6.6 stable.
>=20
>   1/4 vfio: Create vfio_fs_type with inode per device
>   2/4 vfio/pci: Use unmap_mapping_range()
>   3/4 vfio/pci: Insert full vma on mmap'd MMIO fault
>   4/4 fork: defer linking file vma until vma is fully initialized
>=20
> =3D=3D 6.6 stable adaptations =3D=3D
>=20
> Patch 4/4 (fork: defer linking file vma):
>  - 6.6 uses vma_iter_bulk_store() which can fail, unlike mainline's
>    __mt_dup(). Error handling via goto fail_nomem_vmi_store is preserved.
>=20
> =3D=3D Testing =3D=3D
>=20
> CVE reproducer (custom fork/punch_hole stress test, 60s):
>  - Unpatched: deadlock in hugetlb_fault within seconds
>  - Patched: 2174 forks completed, zero warnings (KASAN+LOCKDEP enabled)
>=20
> xfstests quick group (672 tests, ext4, virtme-ng):
>  - 65 failures, all pre-existing or KASAN-overhead timeouts
>  - Zero patch-attributable regressions
>  - Leah's 4 specific tests that caused the original revert
>    (ext4/303, generic/051, generic/054, generic/069) all pass
>=20
> VFIO + fork stress test (CONFIG_VFIO=3Dy, hugetlbfs):
>  - CVE reproducer with vfio modules active: zero warnings
>=20
> Yocto CI integration (~87,900 tests per build, LTP+ptest+runtime):
>  - No known regressions
>=20
> dmesg analysis (KASAN, LOCKDEP, PROVE_LOCKING, DEBUG_VM, DEBUG_LIST):
>  - Zero memory safety, locking, or VMA state issues across ~38 hours
>    of testing
>=20
> =3D=3D References =3D=3D
>=20
> [1] Revert discussion:
>     https://lore.kernel.org/stable/20240604004751.3883227-1-leah.rumancik=
@gmail.com/
>=20
> [2] Leah's backport attempt and vfio discovery:
>     https://lore.kernel.org/stable/CACzhbgRjDNkpaQOYsUN+v+jn3E2DVxX0Q4WuQ=
WNjfwEx4Fps6g@mail.gmail.com/T/#u
>=20
> [3] Axel's vfio series and Alex's feedback:
>     https://lore.kernel.org/stable/20240716112530.2562c41b.alex.williamso=
n@redhat.com/T/#u
>=20
> [4] Axel's 6.6 vfio series (withdrawn):
>     https://lore.kernel.org/stable/20240717222429.2011540-1-axelrasmussen=
@google.com/T/#u
>=20
> [5] Axel's 6.9 vfio series (accepted):
>     https://lore.kernel.org/stable/20240717213339.1921530-1-axelrasmussen=
@google.com/T/#u
>=20
> [6] CVE details:
>     https://nvd.nist.gov/vuln/detail/CVE-2024-27022
>=20
> [7] Original report:
>     https://lore.kernel.org/linux-mm/20240129161735.6gmjsswx62o4pbja@revo=
lver/T/
>=20
> [8] Mainline fix:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D35e351780fa9d8240dd6f7e4f245f9ea37e96c19
>=20
>=20
> Alex Williamson (3):
>   vfio: Create vfio_fs_type with inode per device
>   vfio/pci: Use unmap_mapping_range()
>   vfio/pci: Insert full vma on mmap'd MMIO fault
>=20
> Miaohe Lin (1):
>   fork: defer linking file vma until vma is fully initialized
>=20
>  drivers/vfio/device_cdev.c       |   7 +
>  drivers/vfio/group.c             |   7 +
>  drivers/vfio/pci/vfio_pci_core.c | 271 ++++++++-----------------------
>  drivers/vfio/vfio_main.c         |  44 +++++
>  include/linux/vfio.h             |   1 +
>  include/linux/vfio_pci_core.h    |   2 -
>  kernel/fork.c                    |  29 ++--
>  7 files changed, 140 insertions(+), 221 deletions(-)
>=20

For vfio bits:

Acked-by: Alex Williamson <alex@shazbot.org>

