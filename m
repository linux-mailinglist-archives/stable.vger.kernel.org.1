Return-Path: <stable+bounces-216467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n2UBGtUMkGnRVgEAu9opvQ
	(envelope-from <stable+bounces-216467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 06:49:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B141413B28E
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 06:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05C48301E3DD
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 05:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3E4289374;
	Sat, 14 Feb 2026 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Woqy9tz/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7E26299
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771048146; cv=pass; b=GuLaRiwr5/J3XU3J0ErJGoSlTcTLHaH/ztTz7RMM+bGD5ZCXNk93Edl3+eshmPjOvYGbCUYuHo6qYNfsqcmD9igMRZzmBlrDP4pBicJGIRomy2OBpaAC7Frjy/ErpnGtPpKA7h12q6oM91d3cnXeJONAJl0OGv6XHsUQidhuDvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771048146; c=relaxed/simple;
	bh=6JMac4aQGVmaK4xSD2v1MguCqeh8mIw1wC9GX3T+jy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJWHd7rjb1XIsZEk+IV3uPovEZAua+CUfz2H1YxFQ33VyEEj53IIeloeL4UPqt7yZfPR/y5neooCjZowtIIXuyk76LtI5vRWVA0cqyRKw5Pznp0KIi7ea9NnerDfbrF3URm7/Cu3y4/Nawu7azNXsg5bpwWCes6xdRvIdS+nsYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Woqy9tz/; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b7da62b487so2807517eec.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 21:49:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771048144; cv=none;
        d=google.com; s=arc-20240605;
        b=hbaqbemIFpoPTcOTi085inOXJaE5PqYf7WRwS/0FZoEXiG2JniFp41RzaGxIcy5tk3
         5PCfzlKxHy5I+uF6xSdZ6WdYG/A0OhKJlKDE/l9ghVgZDTc4fBAaHi+DV5otqzaR2R5/
         qvNuAixAVparMU35DHuybMiVT9VSsMosbRQfxryd3CNzQAuC03A/93mVcIvJUL0zSxop
         CSb6w1AzzA99EYaCEkJCw+XhZACxgqEuWUCcgnS77p83gnp0jzRIrPLwR+zsrdYIrv34
         OPYx+q+kXBMaLTjRWi/bUefh7oIzwTjgLqtXlF2ItwBq0gBx5tqnkLgqqx2QhfEK8aUI
         pD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pL/rVbYopYU/xWf3Hc+ezZslblCZtsIBlSm64k0TdYc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=GqcB+qphDxZTZiqwK5zr4LqNfpAyZ3by2o/ROzRkYJII0unUT4nKL86jDWk+wJgL+f
         Pvd6HAfYZDbbzhQCWWQmKuGAN8RflLua1AHdERTTeC42NR2DLw+x6/DRZSvZtzS4jNYh
         HuotHaLE5SCI18RScO548bJfhwGIdeQygZGGOE1JxEkrULDzpVvSSu1rj4JEZhPJHPa1
         mTrueECFuWaB9zzzyKM4/kipB+Ol6ipbNqEemdl8yFO3/Z4rVTkVEoLcTL0+1LaXfASW
         FVwCBkxcbPWObCD6A/HngFZIHXTXPMQe8S4aLMMkQu3y8Eu0Zv8lcqVJ/qYdsp+VcDxX
         7Q7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771048144; x=1771652944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pL/rVbYopYU/xWf3Hc+ezZslblCZtsIBlSm64k0TdYc=;
        b=Woqy9tz/+wEzf2zWoeOTg8VP+3V61pDHaah8vosf2bN/gV6oYaGs7SmkeNmz/fOfjm
         ATGZ8Cq8nr0mJSvcSb5pfRrHJHaZsK3CEsfdZBYaSTv6oFM050tSfORvNv5eVwCVehC7
         azTr0o1nGXnxBy22sRaOJcrbxDvrkKZ4M2JFeLddSZiJ8A87g6Qs0sG80Hm3Sm/Ak1OD
         5ki3ypWj6BEjB6K6hS9ye/EgQ6Pd7CM97kzreeYn7YpyksRQtZyARke0qZTTe9XPa5Dl
         OHnlk6UFrzD9PTuL0+0jpYl4BrbCVqQwbJGx3n8aCJqVX53FBXuwJcefXBFgVnPXOKRo
         8gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771048144; x=1771652944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL/rVbYopYU/xWf3Hc+ezZslblCZtsIBlSm64k0TdYc=;
        b=SU+jwYzvsAZWI9AvQxJM4Q9VyKJHH7OwLQzi4swTL9aRnQpsHAx3HDs7POL1p1h2iL
         igxotgGpHdy1AEV8ZxbkHffevMQxtfjeCAhv3Ls0Eg5amDE/ppJCIuwYT3yVDI9Hk4xN
         6eBU7ryOWIjpDxVQzek7zByiBLU1Ken0a1g/8UTTBqEPQ1iPcWI83sJoWI/u1KOyCNHq
         s5aW3CypOxuNuH3komeSFSE9dBTYLORD7gN6GU/DrJ42zsaXD1K68mJV3K5WydSUDV1/
         v7Bn98ihf7vNrnw/klJeUtnJtV4ydCrrwg7JjFQUsr60NeBjCchGG/qjZeMYVUqvsp6t
         YJwA==
X-Gm-Message-State: AOJu0YxGQfmURjDxS2lOAc2TFxFbuHm5ob5RModDaCIIjLcpy/SiqAOy
	VpKF8+27EXcSiyQIDVIbVp7gCFSMKUgR3MLtSjZ5wu8b2BHOEL+AdkEF0vYnTvSB8oTezz7PlO+
	SOyeD1FZRpEU5Qjp3SNBeLkeBAvBatMk=
X-Gm-Gg: AZuq6aJex4JWMtJ8JUd0yZFPgBqR8lVhmRPn8oUwWK9++NYP2HTZ8tdk2vbxOg7iZAT
	vBQEink28B705ZFkr8E1ZY40nPYN/LvfZSnWVeaGDr0tnCf9IlKsAO8QJrmDtY2dQy82xXjX6+H
	529UWnvC8grmZN4Cy6flbPl+Kh8BDXM07JYuco16V4Yu6dPiV5yvhePXSPB4Deoeifn3isq+dl3
	XpPIiPmFODwwts5QEbgwOB6pv1Xs4xYzuTWzT4StgxmNPQEUxcMzXWazNrm1rJ+WaAWR96b3IGY
	BvFE7mqaef5S5S9u8QCpy9vkGgXA+QvYjNqVDEF9l5xc/Ljk0wWX3WmyKEvhMUIajalRnFf6H0G
	n2q7Cjz2H2HKn6+aM5KghtqKU8QWwaL9mhrSO9iUQwp3k6uGREzd1uLvD6mDsDzyi9e2BcJoO5H
	eUizWVzi27T4QQCuT7tUE=
X-Received: by 2002:a05:7301:168e:b0:2b8:6573:2d35 with SMTP id
 5a478bee46e88-2babc42e1f4mr2149557eec.2.1771048143570; Fri, 13 Feb 2026
 21:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213134708.885500854@linuxfoundation.org>
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Sat, 14 Feb 2026 06:48:51 +0100
X-Gm-Features: AaiRm51_Ulrx2MkwQSoBKB2WfT2plhQjy74CL-1H59OXIjjQ59srhznvWjq2yjM
Message-ID: <CADo9pHgnDxeeOuaTDG3se2rrAT8EEMau16ZyjHYZwHC2e-jYWw@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/49] 6.18.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B141413B28E
X-Rspamd-Action: no action

Tested on: Arch Linux Machine a Dell Micro 3050 with a
model name    : Intel(R) Core(TM) i5-6500T CPU @ 2.50GHz
and works as it should


Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den fre 13 feb. 2026 kl 14:52 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.18.11 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.18.11-rc1
>
> Danilo Krummrich <dakr@kernel.org>
>     gpio: omap: do not register driver in probe()
>
> Ali Tariq <alitariq45892@gmail.com>
>     wifi: rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add
>
> Liu Song <liu.song13@zte.com.cn>
>     PCI: endpoint: Avoid creating sub-groups asynchronously
>
> Jeongjun Park <aha310510@gmail.com>
>     drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free
>
> Darrick J. Wong <djwong@kernel.org>
>     xfs: fix UAF in xchk_btree_check_block_owner
>
> Chao Yu <chao@kernel.org>
>     erofs: fix UAF issue for file-backed mounts w/ directio option
>
> Gui-Dong Han <hanguidong02@gmail.com>
>     bus: fsl-mc: fix use-after-free in driver_override_show()
>
> Anil Gurumurthy <agurumurthy@marvell.com>
>     scsi: qla2xxx: Query FW again before proceeding with login
>
> Anil Gurumurthy <agurumurthy@marvell.com>
>     scsi: qla2xxx: Free sp in error path to fix system crash
>
> Anil Gurumurthy <agurumurthy@marvell.com>
>     scsi: qla2xxx: Delay module unload while fabric scan in progress
>
> Shreyas Deodhar <sdeodhar@marvell.com>
>     scsi: qla2xxx: Allow recovery for tape devices
>
> Anil Gurumurthy <agurumurthy@marvell.com>
>     scsi: qla2xxx: Validate sp before freeing associated memory
>
> Bitterblue Smith <rtl8821cerfe2@gmail.com>
>     wifi: rtw88: Fix alignment fault in rtw_core_enable_beacon()
>
> Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>     hfs: ensure sb->s_fs_info is always cleaned up
>
> Edward Adam Davis <eadavis@qq.com>
>     nilfs2: Fix potential block overflow that cause system hang
>
> Bibo Mao <maobibo@loongson.cn>
>     crypto: virtio - Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req
>
> Bibo Mao <maobibo@loongson.cn>
>     crypto: virtio - Add spinlock protection with virtqueue notification
>
> Kees Cook <kees@kernel.org>
>     crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly
>
> Thorsten Blum <thorsten.blum@linux.dev>
>     crypto: octeontx - Fix length check to avoid truncation in ucode_load_store
>
> Thorsten Blum <thorsten.blum@linux.dev>
>     crypto: iaa - Fix out-of-bounds index in find_empty_iaa_compression_mode
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: hda/conexant: Add quirk for HP ZBook Studio G4
>
> Zenm Chen <zenmchen@gmail.com>
>     Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB
>
> Gui-Dong Han <hanguidong02@gmail.com>
>     driver core: enforce device_lock for driver_match_device()
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: let send_done handle a completion without IB_SEND_SIGNALED
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: let smbd_post_send_negotiate_req() use smbd_post_send()
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: fix last send credit problem causing disconnects
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: make use of smbdirect_socket.send_io.bcredits
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: use smbdirect_send_batch processing
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: introduce and use smbd_{alloc, free}_send_io()
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: split out smbd_ib_post_send()
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: port and use the wait_for_credits logic used by server
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: remove pointless sc->send_io.pending handling in smbd_post_send_iter()
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: remove pointless sc->recv_io.credits.count rollback
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: let smbd_post_send() make use of request->wr
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: let recv_done() queue a refill when the peer is low on credits
>
> Stefan Metzmacher <metze@samba.org>
>     smb: client: make use of smbdirect_socket.recv_io.credits.available
>
> Stefan Metzmacher <metze@samba.org>
>     smb: server: let send_done handle a completion without IB_SEND_SIGNALED
>
> Stefan Metzmacher <metze@samba.org>
>     smb: server: fix last send credit problem causing disconnects
>
> Stefan Metzmacher <metze@samba.org>
>     smb: server: make use of smbdirect_socket.send_io.bcredits
>
> Stefan Metzmacher <metze@samba.org>
>     smb: server: let recv_done() queue a refill when the peer is low on credits
>
> Stefan Metzmacher <metze@samba.org>
>     smb: server: make use of smbdirect_socket.recv_io.credits.available
>
> Stefan Metzmacher <metze@samba.org>
>     smb: smbdirect: introduce smbdirect_socket.send_io.bcredits.*
>
> Stefan Metzmacher <metze@samba.org>
>     smb: smbdirect: introduce smbdirect_socket.recv_io.credits.available
>
> Henrique Carvalho <henrique.carvalho@suse.com>
>     smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: add chann_lock to protect ksmbd_chann_list xarray
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_off reset in error paths
>
> Henrique Carvalho <henrique.carvalho@suse.com>
>     smb: client: split cached_fid bitfields to avoid shared-byte RMW races
>
> Li Chen <me@linux.beauty>
>     io_uring: allow io-wq workers to exit when unused
>
> Li Chen <me@linux.beauty>
>     io_uring/io-wq: add exit-on-idle state
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                           |   4 +-
>  drivers/base/base.h                                |   9 +
>  drivers/base/bus.c                                 |   2 +-
>  drivers/base/dd.c                                  |   2 +-
>  drivers/bluetooth/btusb.c                          |   2 +
>  drivers/bus/fsl-mc/fsl-mc-bus.c                    |   6 +-
>  drivers/crypto/intel/iaa/iaa_crypto_main.c         |  12 +-
>  drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c  |   2 +-
>  drivers/crypto/omap-crypto.c                       |   2 +-
>  drivers/crypto/virtio/virtio_crypto_core.c         |   5 +
>  .../crypto/virtio/virtio_crypto_skcipher_algs.c    |   2 -
>  drivers/gpio/gpio-omap.c                           |  22 +-
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c           |  38 +-
>  drivers/net/wireless/realtek/rtl8xxxu/core.c       |   1 +
>  drivers/net/wireless/realtek/rtw88/main.c          |   4 +-
>  drivers/pci/endpoint/pci-ep-cfs.c                  |  15 +-
>  drivers/scsi/qla2xxx/qla_gs.c                      |  41 +-
>  drivers/scsi/qla2xxx/qla_init.c                    |  28 +-
>  drivers/scsi/qla2xxx/qla_isr.c                     |  19 +-
>  drivers/scsi/qla2xxx/qla_os.c                      |   3 +-
>  fs/erofs/fileio.c                                  |   7 +-
>  fs/hfs/mdb.c                                       |  35 +-
>  fs/hfs/super.c                                     |  10 +-
>  fs/nilfs2/sufile.c                                 |   4 +
>  fs/smb/client/cached_dir.h                         |   8 +-
>  fs/smb/client/smbdirect.c                          | 523 ++++++++++++++++-----
>  fs/smb/common/smbdirect/smbdirect_socket.h         |  18 +
>  fs/smb/server/mgmt/user_session.c                  |   5 +
>  fs/smb/server/mgmt/user_session.h                  |   1 +
>  fs/smb/server/server.c                             |   6 +-
>  fs/smb/server/smb2pdu.c                            |  12 +-
>  fs/smb/server/transport_rdma.c                     | 147 +++++-
>  fs/smb/server/transport_tcp.c                      |   3 +-
>  fs/xfs/scrub/btree.c                               |   7 +-
>  io_uring/io-wq.c                                   |  27 +-
>  io_uring/io-wq.h                                   |   1 +
>  io_uring/tctx.c                                    |  11 +
>  sound/hda/codecs/conexant.c                        |   1 +
>  38 files changed, 799 insertions(+), 246 deletions(-)
>
>
>

