Return-Path: <stable+bounces-216468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKaHBfUMkGnRVgEAu9opvQ
	(envelope-from <stable+bounces-216468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 06:49:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0513B29F
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 06:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65E933016D1A
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 05:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D752BE641;
	Sat, 14 Feb 2026 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuGndOJp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4C26299
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771048178; cv=pass; b=OQeFM7Y2ZHu24d1ESGsare+nVKWeHdD/moC1dPwBlyIN6F51Ps56ON873SpDxEf0x/Q1bezut4cvoeRzUFY6fdMHVGvVwx9JTleZU7mI0ac92l1YF2Uq/eGL177HLLAnQGBrN08KFttWJkM8FrAfc3k0OXrjCt7ogDt0KQzp1RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771048178; c=relaxed/simple;
	bh=GRavVQhmvwlNCgvONobE5u7Ll0O52KaT/yj4QRQi1qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poJw4+XazF0Y5DkDbl2dQnr/6zN7nJzBI3S+JNHIliILDMABQvDigsWgCQmCO9rD7//3YJlo1KWYhMLTqvR/kF93YT8J/uAWknHHCiMu/6g33Law1w6tF6nwzfsrGDqMeSfpuPyhmg1j5dxfcaNDlppj8iGujPjAdhs0Z580vnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuGndOJp; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2baaceb4613so1261380eec.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 21:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771048176; cv=none;
        d=google.com; s=arc-20240605;
        b=UEi/hJfFbnq2CXksgduoGfcjQrQiVy1lb2py9K2dg1cnXOYzmaUJbGx/5XnASXDdUh
         ViVLYI4JXl2dLbPOH3JTk8SN+MGGy02+SJTv8wb6RACkW4FXXOCmH6j/t/iFSSwoCTr1
         xa+K9MzbNn5Ht2OS9JOqTkak73nuNhpKvBrG1ULHT7pKVFM6RDO0JZUyA/3WpS9meEgc
         +6rS+1mKDcpmZ7DQHWtmiiXDsSYn2ARG9Hy6M7Wbtot2DaY+VgpIPv4Z+D88GGCO3Q5C
         zp19DBi3W6u2Zcm4Tkgr+Op5u5jnz1Ts2CgYN7/17kNlr/GKAJ++4VbpnCMKklR8bZde
         PDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JwLwqu8ou1Ms5gD688BvI+MOyMsrVQo8AuFKGOKiXGA=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=YTM9TOKjtDb/98enYqlXa7bbrzFSHwYn5HJH9+BWdbWkPT6DiSyoH3UO+ENkJdiuXO
         Zdn8FUxocvUXlfIOtOorr2BufPr/E6mmESZMuiWM21WJZj6FEA3bNpWY+7t/39SY0QCV
         X8ArFVJZMzMUxkEq93c7sKPoxP1phT9UPkQyD6H1/0OXfwcNh6BEaJqPfMu1mXDv6tVz
         e6pqPeXRrz5T+S6bsM+jz7sCW8+j8gSAj0H0B80u0PcUa1dqfk3djh6Qnj+pzcEqiomO
         eZ0SjnC0LaS2bemlofaCem6SdO863kmReEMnDFgkh0xsiWmwLUAUiT9tZtbe2vOb5y9q
         hnHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771048176; x=1771652976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JwLwqu8ou1Ms5gD688BvI+MOyMsrVQo8AuFKGOKiXGA=;
        b=WuGndOJpOtw5aVJqrt6glI3L3qPgsB2QXoTlBVpMyMu2I/lYUJQHR1MpopAWllAOPA
         Trt/HjxNoEc8GpzavfxtWTQ3QQqoLzvPkykxKyeuiZ2Y5ZO929mbFFjSMugMKyS56D5n
         B07AFynADlELXQW0CQSr8ATuJomaKdmnGMkxPeBao0m3yx9Hv/L1OeYh3LF7lqTNg6IW
         SGoG3ewb7a7QLgzjU2l4WvW63qxJ0QGOJQDZVbFcETroAl0AlfjJC+4EtkVStqEEEOUk
         6OYtKhaDDwFPGQGilGkyhPt0AYXqS21E6SAXdSkf+WiRQEELpp9P8exXkuiMDSW5gPpn
         PjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771048176; x=1771652976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwLwqu8ou1Ms5gD688BvI+MOyMsrVQo8AuFKGOKiXGA=;
        b=kK+HmEk7dmpV8PkXhTfKmFMHRXENMP2kpvkbO+wn9IC3pLO7PYDp+lLmpgarHBLfqM
         PHXQkywng5sdrME+7TLor1XrpFa2BJgsa7qr71ETRkq8I/0bolDtOwXQIORScY47hDI6
         liMQvoxNFcKTUAlY9cxJ0EipOJMu/2DhjwaqjlGOYPm2Q7nidA3oc7+qNmhbsoQ3oJfX
         T3GB5+RadzlrXoUX9a5glLvXkr383ZyU6kZ8IK7KlphXvJhG7NOpHinu4gGE3AcuZYVQ
         6EqFhKqR0FJlq3dmMyEkkQwULG02tuTOkmdO/7Lk+1HUZ3Pnsc6VrUAiu8hsRU08m/Wv
         JYxA==
X-Gm-Message-State: AOJu0YyOujUkKbXOsRqylXVqdJ1SgXbjZ1tkM/OQ/PtWZo3dwVpeGZ/2
	E4h8+95Pt7DurGRvy6ZAUDtHLqx+OvkxYLJMXdRIGwoG0GtgpDs3uFOIn/U48b3z9Nnbs13sp1x
	mCrMabSgSkUqJLG1B/a9yPldFFUthGLY=
X-Gm-Gg: AZuq6aIJFDNswX4vmaix0HAnMN1stIEMYIttfsXg8c3vd/ZWN+Hs3D5dyD8Eio3Y/FO
	IqNiyund8TGc/dvWa4eDeZx3CGtZxI3Iy6xgSGh1+PxxfMROZD+yUBv05L17/zAaJTEdctaDEk0
	wqMjq6RejS5WsxSoJO+m4qIka1GC0K6Lw5JOm1eGybJNqKwTA/rftcIPTuWe69COcdpdhoEgjp2
	+7H1aECsMyC/d9pphb8pFbKKfWjOgNUOEUBFwSoWixrrs4OFy/lTODCPIAD9LGCRsHAibNB6uCi
	LZKupNxs+2/pL3iErJ35WGPu+mOQ0EmvB4OcjEnp4g1MOv2Ufgbg6WXfSIMG/klPlTPCVLKAsTM
	w/6/wMxUFzoVQc678Y56wm1+0mUR/EJS3LmDrm73r/+1RRnUx0KB4eHRAiKF9eR4iZGLQEfn52c
	MSQbyeq6MzHVmMLYPsnY4=
X-Received: by 2002:a05:7300:3254:b0:2b8:6896:d0e6 with SMTP id
 5a478bee46e88-2bac7202153mr930808eec.7.1771048175776; Fri, 13 Feb 2026
 21:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213134708.713126210@linuxfoundation.org>
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Sat, 14 Feb 2026 06:49:23 +0100
X-Gm-Features: AaiRm53UMLsiqobZsnT_Q2ppNv6fWh8Upz83jKoUfWr08gT4yPgG3SV5Ee9db1o
Message-ID: <CADo9pHgVziA9Sa-yEZcoMxzGnCQD5BxSiS-=73b7jmZzNXMhOg@mail.gmail.com>
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216468-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99A0513B29F
X-Rspamd-Action: no action

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den fre 13 feb. 2026 kl 14:51 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.19.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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
>     Linux 6.19.1-rc1
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
> Thomas Gleixner <tglx@kernel.org>
>     sched/mmcid: Don't assume CID is CPU owned on mode switch
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
>  kernel/sched/core.c                                |   7 +-
>  kernel/sched/sched.h                               |   6 +-
>  sound/hda/codecs/conexant.c                        |   1 +
>  39 files changed, 788 insertions(+), 248 deletions(-)
>
>
>

