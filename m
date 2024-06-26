Return-Path: <stable+bounces-55880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A51919847
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 21:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B4BB21335
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8A191477;
	Wed, 26 Jun 2024 19:33:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D412E40;
	Wed, 26 Jun 2024 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430415; cv=none; b=OzUjSpiWAGM+Wp1V70afgJ3dOM9/gbJUv7QrzF75uw+hyG3iSpbeQTa1FplAe0a/aViSDidSBzle7ef6TmLclOPFgZp2ZUdRftyufaIiWGCCoilc49/29wYGzW9PYc1En8ewgPuvpyZtccGpBh/42by8p4iUvI46wwZwJUF8cY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430415; c=relaxed/simple;
	bh=iSTONfzO+oL6kkCeyDDU96ArOeGc54bYqqyEv8IJEwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czfJlhUGc7AIaYiqJF8hM2LstqVycB+336ug/83fyoswcNvzirkKuyr+fgsfcsMz5Z8bTJt21/wxIAUlQkV1d2AXsDl7fBMCKdSW6twgQpYvd7jHhsBg4Fjjs+VzzQbj38ymK+RD+7VzbmGbxL6+bWE8Y87yGDtj62yeZvY1dkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4ABC98179E;
	Wed, 26 Jun 2024 19:25:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id D00476000E;
	Wed, 26 Jun 2024 19:25:36 +0000 (UTC)
Message-ID: <58432885e0b4b5c781be6a83787edd4779a41aad.camel@perches.com>
Subject: Re: Patch "scsi: mpt3sas: Add ioc_<level> logging macros" has been
 added to the 4.19-stable tree
From: Joe Perches <joe@perches.com>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Sathya Prakash <sathya.prakash@broadcom.com>, Sreekanth Reddy
	 <sreekanth.reddy@broadcom.com>, Suganath Prabu Subramani
	 <suganath-prabu.subramani@broadcom.com>, "James E.J. Bottomley"
	 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Date: Wed, 26 Jun 2024 12:25:35 -0700
In-Reply-To: <20240626190750.2060180-1-sashal@kernel.org>
References: <20240626190750.2060180-1-sashal@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D00476000E
X-Rspamd-Server: rspamout01
X-Stat-Signature: ugmqdn3qiqhtwumobbhys3yh1j4sx3cc
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/O61V5AHK/KTQwldSEacqmAPS0hpJgcSg=
X-HE-Tag: 1719429936-589367
X-HE-Meta: U2FsdGVkX18iAD1nNgRJq/l7fs3v/2PrefBvzput6BZK/rsSYvU9k0baSvVG2wuJhmeCVjkSJE85/7LAffTis9hAW/Jb2dANLfQgKUldIF2MEXiIkNTvbbYjVqYPfYWtrBH0uzYoR7vpKtFThKAZ8dfEX5zLhPjUaQU6EbzOX+TVBqiFebDbfvC//q2lEStGF8C9OsALapskHNVGb+56J4Bq/Dh5SzhW2hJkthEp7RUQOEktxgQZ3U3wTWgHbwUPSq71r361qVxCcN+TlsOa/5DM7edZfHWxkGkb4HVFaghTRrcYuJ86LIQwNrqtRZ8IplIdce65bX3UJ+/NKX7LycGlwkDZ0/qpxRuCbiVEPZV2s6Uh5tZ8vE1YMzGHNuqssUZoJA+G+zrRTIXjYxJpQMzeRXKZjnXfFR6O0JiagGpXzZnxb1aBQ6wYKirpGPiDsovAnTGDa0jekRLjNgdivMc4NS42p4LAxiGrXE9dNMM=

On Wed, 2024-06-26 at 15:07 -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     scsi: mpt3sas: Add ioc_<level> logging macros
>=20
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      scsi-mpt3sas-add-ioc_-level-logging-macros.patch
> and it can be found in the queue-4.19 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
[]
>    Stable-dep-of: 4254dfeda82f ("scsi: mpt3sas: Avoid test/set_bit() oper=
ating in non-allocated memory")

Huh?  This doesn't make sense as far as I can tell.

> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/m=
pt3sas_base.h
[]
> @@ -160,6 +160,15 @@ struct mpt3sas_nvme_cmd {
>   */
>  #define MPT3SAS_FMT			"%s: "
> =20
> +#define ioc_err(ioc, fmt, ...)						\
> +	pr_err("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_notice(ioc, fmt, ...)					\
> +	pr_notice("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_warn(ioc, fmt, ...)						\
> +	pr_warn("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +#define ioc_info(ioc, fmt, ...)						\
> +	pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
> +

This only adds ioc_<level> macros and the
nominal stable dep patch below doesn't use them.

$ git log --stat -p -1 4254dfeda82f
commit 4254dfeda82f20844299dca6c38cbffcfd499f41
Author: Breno Leitao <leitao@debian.org>
Date:   Wed Jun 5 01:55:29 2024 -0700

    scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory
   =20
    There is a potential out-of-bounds access when using test_bit() on a si=
ngle
    word. The test_bit() and set_bit() functions operate on long values, an=
d
    when testing or setting a single word, they can exceed the word
    boundary. KASAN detects this issue and produces a dump:
   =20
             BUG: KASAN: slab-out-of-bounds in _scsih_add_device.constprop.=
0 (./arch/x86/include/asm/bitops.h:60 ./include/asm-generic/bitops/instrume=
nted-atomic.h:29 drivers/scsi/mpt3sas/mpt3sas_scsih.c:7331) mpt3sas
   =20
             Write of size 8 at addr ffff8881d26e3c60 by task kworker/u1536=
:2/2965
   =20
    For full log, please look at [1].
   =20
    Make the allocation at least the size of sizeof(unsigned long) so that
    set_bit() and test_bit() have sufficient room for read/write operations
    without overwriting unallocated memory.
   =20
    [1] Link: https://lore.kernel.org/all/ZkNcALr3W3KGYYJG@gmail.com/
   =20
    Fixes: c696f7b83ede ("scsi: mpt3sas: Implement device_remove_in_progres=
s check in IOCTL path")
    Cc: stable@vger.kernel.org
    Suggested-by: Keith Busch <kbusch@kernel.org>
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Link: https://lore.kernel.org/r/20240605085530.499432-1-leitao@debian.o=
rg
    Reviewed-by: Keith Busch <kbusch@kernel.org>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt=
3sas_base.c
index 258647fc6bddb..1092497563b22 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -8512,6 +8512,12 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->pd_handles_sz =3D (ioc->facts.MaxDevHandle / 8);
 	if (ioc->facts.MaxDevHandle % 8)
 		ioc->pd_handles_sz++;
+	/*
+	 * pd_handles_sz should have, at least, the minimal room for
+	 * set_bit()/test_bit(), otherwise out-of-memory touch may occur.
+	 */
+	ioc->pd_handles_sz =3D ALIGN(ioc->pd_handles_sz, sizeof(unsigned long));
+
 	ioc->pd_handles =3D kzalloc(ioc->pd_handles_sz,
 	    GFP_KERNEL);
 	if (!ioc->pd_handles) {
@@ -8529,6 +8535,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->pend_os_device_add_sz =3D (ioc->facts.MaxDevHandle / 8);
 	if (ioc->facts.MaxDevHandle % 8)
 		ioc->pend_os_device_add_sz++;
+
+	/*
+	 * pend_os_device_add_sz should have, at least, the minimal room for
+	 * set_bit()/test_bit(), otherwise out-of-memory may occur.
+	 */
+	ioc->pend_os_device_add_sz =3D ALIGN(ioc->pend_os_device_add_sz,
+					   sizeof(unsigned long));
 	ioc->pend_os_device_add =3D kzalloc(ioc->pend_os_device_add_sz,
 	    GFP_KERNEL);
 	if (!ioc->pend_os_device_add) {
@@ -8820,6 +8833,12 @@ _base_check_ioc_facts_changes(struct MPT3SAS_ADAPTER=
 *ioc)
 		if (ioc->facts.MaxDevHandle % 8)
 			pd_handles_sz++;
=20
+		/*
+		 * pd_handles should have, at least, the minimal room for
+		 * set_bit()/test_bit(), otherwise out-of-memory touch may
+		 * occur.
+		 */
+		pd_handles_sz =3D ALIGN(pd_handles_sz, sizeof(unsigned long));
 		pd_handles =3D krealloc(ioc->pd_handles, pd_handles_sz,
 		    GFP_KERNEL);
 		if (!pd_handles) {



