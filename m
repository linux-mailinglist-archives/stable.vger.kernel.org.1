Return-Path: <stable+bounces-233006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BrgKmVdzmnvnAYAu9opvQ
	(envelope-from <stable+bounces-233006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:13:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A74F388E6C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B1E3091FC5
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD73C8721;
	Thu,  2 Apr 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABjT3/v7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FA23DCDA6
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131853; cv=pass; b=nYZ8Pc+CkqLamenu280NBnQidul15Q4AgWCSqt6/UPP6uminaeLNz34PWgFFZKUiE5lMI54b5ZGN8vCl634zjrs4Uwe8aAvJu7Kmr9NZ3TuR6C9D4yi15jTupIjXOYPtBUxf6RsLWCRcMF9SDSuKYVMyJe0W7MYudg9Z0mncm4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131853; c=relaxed/simple;
	bh=Jx2vOZ3aK+H94UvwlSlpY2GIR8TTTJNpCM772tGT+EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9ktWxPhN5NRujCocLg7QacCTQyALBvwGMLNaXT8Od6QCY9xeAhH36/gpxyFIJMY68OmM43pP7tXsBhAm5fWH6HG09vDA1HRrKDVvmR3RL0exMst8ez3kXDKVDxCfi4J00xQk4feUx+RF0G8mQlcF/fnPZVs/CIcOHULLF6F6a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABjT3/v7; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64eee7b83cfso644546d50.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 05:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775131851; cv=none;
        d=google.com; s=arc-20240605;
        b=K0Gt6i026JOzLlzrxf7/jp8kkGi3/ckdOtRB7CARdIqE3gDlqh7kxrAPhkgQUBeJZW
         VM0uxMxcnrsfgmIO2xJkotNwIKwgpAV7deyMKLq5GUUtl9yDEJmaYfNHhfs69+/3iu6Q
         1dwAasBwV9Vl4ikzPl8Zj2hEQdXGvuhBg9uglax+1nRK4NAuYheSBGtYzCOqcFukJvxS
         XHl9oP9ti7jcr/Ty9Ejw/hT4nTgAYp1TnWrGOtlxzMv/kFeqlgLELdmRVltCZipSpKD3
         7wvNV/HsNPiTbQK9FZuFMmtlQwJuRpQQpPNhFe+bQ/HOHcf52gGA4Ucr+zZ9aNXYKqM0
         gEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vXGE4RWiA7WqJLGf36CVelIpTJ6eR3ehqb3g2RtbVMY=;
        fh=SjxGodSC78YX0EDHDfpVtHx1L7DdO+gU2tCymzxp0KI=;
        b=WKj3cGxK6EKYVCdTE/HlJGqapcpKC52ZTx/ok9vDigl2HBEkKjpUA0wazyrL+JcyAR
         ZH5Rtzbq054Mc9kV3RkHLlkPszLHwtqts+nY/jlkkQZqlvYF0s5xItFvjKgTnQKbGDYx
         yPikGMgvm8E/BFG3lTiXligZCsZWtCW5CONoYu5btt7IvbThHtkClOtuXsCxluavQY93
         1a6wccAF5ihEw9V4S7VclLoYNdWXxDTZoT5apaTJlHobxS/lJZUsFXUpZgG5rvOOmqch
         HHQx2PCPJL8GMQ8gGanVb006XrhNctmpyC2d4fy3E6qXl5ARUr01z0kw24EUhco/3RDe
         SAoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775131851; x=1775736651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXGE4RWiA7WqJLGf36CVelIpTJ6eR3ehqb3g2RtbVMY=;
        b=ABjT3/v7Q+q0SfPTQH7M/1bch9ddn6IaqKesPw8cpoJPeDfxQJwQWZ9KRv0tgBC747
         ybFTcNBJC0YUYRRxrp842L6w9huXIjRl7mu7uV4X5/QqCkHuyLVQFg2wOOGGqVa3hMlI
         00xmHzi97DSzYZd4NHz+0tq21PB+9UNUzjfm99BPQT+iH8FWQqBbUl2IN1PDfhSTLs+r
         CiBtpPr7EQFUXmorM2RbwawnO0JyB9nlsraYf/wBwc3EgCbmsIIeS09EC2Um6jwQQsFP
         27LH8tfRkc3x63ZhF4OZSVrci5m+E8+nv0aXy4Tw4ffeme/n/q7wcCkm1dHyzOr7/X8W
         vlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131851; x=1775736651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vXGE4RWiA7WqJLGf36CVelIpTJ6eR3ehqb3g2RtbVMY=;
        b=MreytVjjaDEpykzSXa0lc6pMgdg/q0PcXjD8/MDCtk+ZCKUjwuRKLszskCuRjnH8ry
         BRTWwhbqxe60oqnR5eslIads4qjg7ksVQszAlKw9xtupgmvx+02FsiAfnhd+W4VLsOsU
         R/PYkE7p+FNrSyiC4bkt4tIzaHq9JGYtkwEW3+NqzPu+F7D8fgx8T4U2XYzdun/4sdqQ
         58i/sKpJ2lqaT5xSjYh8kBiRvPgRlg+gu24ymXLGKNtdWOEQ3fyQUfFxk//1pUhDZBE8
         LaRIa1UuiIZ9K3fdPo0nm1xuUl+rlKAndXsgF95FRjnTOximFks5+knvHLKKpmYHlGRr
         d4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTmQgv2PRT8Eyr6ufk0JUuY6Q35Zqiq34l5Rl96rkg4pxlni9O4mZYwQKsayDF+FvoLQl35Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjk0PtQ86kUZiWDOrAbKik1BLU9DDuKsOS1kpVlEq9cWXOPCWu
	6zAPVAc3tYS0KQkgovwS8xbv59dmcCnc1dDW0ioqrnv74hjcS7+hV9zXkdH4aZcOZDrffTOuCRf
	NDMl5uoqSiTusKxo0hrgezKc0PjyufQQ=
X-Gm-Gg: AeBDietXnAGQPz9KYXmElEeaLNOekRtFhBwuIcMDvbFEw8ogW3ALytGHkkBboLaDles
	bv0S9f/UMmjtvjJ+m9uAdH1ji7nMmTW6ZxJrQYb+WzZKTJaGFJiQjdBXkl5CS0ituKE+Mt6ZsxI
	OC7exauSyceG+2sN10QTa5BPnDV4z/UA36q/MsF1oGn2uY/M3J5ovJVIcrIpZX7JRljC06zYrGP
	musE5+qfx39FNdvroNnmnTovHxWr9cwUzTpEYyL6m3EPDDE34mz8W1miS8rh2BqIlnJgrAVyVqh
	Pz7SGT6W
X-Received: by 2002:a05:690e:12c2:b0:650:3e1f:9079 with SMTP id
 956f58d0204a3-6503e1f945emr1607300d50.10.1775131850932; Thu, 02 Apr 2026
 05:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401094003.1482794-1-lgs201920130244@gmail.com> <87h5puxoa2.fsf@intel.com>
In-Reply-To: <87h5puxoa2.fsf@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 2 Apr 2026 20:10:41 +0800
X-Gm-Features: AQROBzAgDXLDasVS5yX_W4qD-ueX2Hms7568bo3hSjKUDmVrOGa4_8H56gZoHPc
Message-ID: <CANUHTR94+ZEO6d3+Pm1cdHw3firrAaVqxO90XwfHGrAkx37wsg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: fix double free in idxd_alloc() error path
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Fenghua Yu <fenghuay@nvidia.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233006-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A74F388E6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinicius,

Thanks for reviewing  =E2=80=94 the feedback is helpful.

I'm working on top of v6.19-rc8-214-ge7aa57247700.

Regarding the concern about put_device(conf_dev) triggering
idxd_conf_device_release() and hitting a NULL idxd->wq in
destroy_workqueue():

idxd_conf_device_release() does not call destroy_workqueue(). That
call lives in idxd_cleanup_internals(), which is a separate code path.
The actual release callback is:

static void idxd_conf_device_release(struct device *dev)
{
    struct idxd_device *idxd =3D confdev_to_idxd(dev);

    kfree(idxd->groups);
    bitmap_free(idxd->wq_enable_map);
    kfree(idxd->wqs);
    kfree(idxd->engines);
    kfree(idxd->evl);
    kmem_cache_destroy(idxd->evl_cache);
    ida_free(&idxd_ida, idxd->id);
    bitmap_free(idxd->opcap_bmap);
    kfree(idxd);
}

At the err_name point in idxd_alloc(), idxd was allocated with
kzalloc_node(), so all uninitialized fields are zero/NULL. Every
function in the release callback handles NULL safely:

kfree(NULL) =E2=80=94 safe
bitmap_free(NULL) =E2=80=94 safe (wraps kfree)
kmem_cache_destroy(NULL) =E2=80=94 safe (explicit NULL check at entry)
ida_free(&idxd_ida, idxd->id) =E2=80=94 id is already allocated at this poi=
nt
bitmap_free(idxd->opcap_bmap) =E2=80=94 already allocated at this point
So relying on put_device() =E2=86=92 idxd_conf_device_release() to clean up=
 is
correct for this error path.

Regarding the other points:

I agree the patches should be sent as a numbered series.
For the put_device()-then-kfree() double-free pattern in
idxd_clean_wqs(), idxd_clean_engines(), idxd_clean_groups(), and
idxd_free(), I'll address those in the same series.
Will send a v2 series shortly.

Thanks,
Guangshuo

