Return-Path: <stable+bounces-72997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD8996B85D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DEF280E8F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243E1CF5D7;
	Wed,  4 Sep 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKfrDuxP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9B433C8
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445501; cv=none; b=EP6BRfc5Mk0LM/7mvr5phkzH01vDrEpKigiehWFEIpAHZn6nis/xICykiL15H7tE+O86W6ZrkNoSKV8RwVyc6W6HdrwdlTAMQqqroBG8q8cw/0cpdLb9WnRemKVWeIBx7Jxig/aB1IlKImpFilyp8vfqhFh/C+rb47CEGg+Ti0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445501; c=relaxed/simple;
	bh=A1EFQ3c0Bd2i1IGtls7pNgWlQrac2FB14Bp4Icu5jyA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Js57Upbqb03G32dAOc+kDKr8NC3CXndGOcQndN3Y4tjhu71QnT49+omArpf+D8BT7DJb45L9wpDSKpoPZQ/HlWmH3FSXWWGgtExJvrqvdijQ3H7DbPcHnC3MzwUH4RIm8v6gzAXaGHcXB2t40LXOc3BpnwcUYxHjD9uNohAMPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKfrDuxP; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a867bc4f3c4so87766966b.0
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725445498; x=1726050298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPZZujZX2dzMQhGhvqy+dFJdhrrbTDEb3k3K+8c51uE=;
        b=lKfrDuxPcmQnfWNrWUEStyOhvVYYAH93ESVm2gxZBjARME+pUaMS+vSscKyfHIomT2
         Cb3hgkEOI46VHvHyqCcx5xViSCisOW7CfIHn0XeCwXifMQGfDBx6auy+EXCeZx5ZJfi3
         5af9ADzm2ulxryB5/qX/O/Zviw3+CijW0mb/vGnMfmKRUJEiNVAEDp98+PnpDdKdJ67K
         TfCLXLL2COv7Dx1fBFQRk8DsiwMA4ysQqO85TVixWxCEGwonp1hebAT+pRdu1aTbjxMA
         R1X81BntDy6hrdfqhH0SD2ij1yimIzIp1O6zY5SVomEx1QvWzs3YvxGbpu1ZpT59egst
         4zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445498; x=1726050298;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPZZujZX2dzMQhGhvqy+dFJdhrrbTDEb3k3K+8c51uE=;
        b=iMtF1aDpYruh+PIW0fUfD/KckmhUOIEj+QHfTG9XK0UrGDIoeTWC0T7I1YHbckdZnz
         UlATvWB3/fx2SREzEKe4A0AToZ50x8rTE+JkjmU6KZbtuiZwawG4HmIJopO9unQNxFbk
         JMh/hM4mmERH2coqsizlbPVNXMH8+DxBhmVNnUJ/XqiCsU68MOOPbj/55W9OmLaI2LGf
         XZd2fG1D99K63tOvKTvC7/52Mn2eoiBoKkxc1BesKyJNj3KQCElZcYL8GQVqa2qczAdH
         sNaU8+/S2BToXQ/KpnTm7bbailXMtUheANvIGM2fIYkLeyZOdgA/r9Vg9G9GX2Ul14bL
         fiKA==
X-Forwarded-Encrypted: i=1; AJvYcCV37wMb/mQfCONXSZTyFotILXI4vrFLEvcgodijni8IUNvwTBfrcSbSFr2IfPLjORn//FnUnao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+0b8k6XyK4sqLFdIjWUB6qcSHCDoc1/RDO/ivsCYNyTSD/oM
	S+AG4ULy6w9UE1gkRgFJ6ADKGuqV0FSrmnhsqrstxByS11ofMDNxPWfsmFC6BGIgwNqFreZVJFa
	UaA==
X-Google-Smtp-Source: AGHT+IHiohgjTOvfQXqJJzJqZ1yE3svaPfEnshCPM/7n+r56wlNN4ZUiYS25ZvVzgioHQOSoKCK+UeVJhRs=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:8b14:3fea:4a73:501d])
 (user=nogikh job=sendgmr) by 2002:a17:906:a295:b0:a86:8211:48ad with SMTP id
 a640c23a62f3a-a8a431c76eamr169666b.4.1725445498202; Wed, 04 Sep 2024 03:24:58
 -0700 (PDT)
Date: Wed,  4 Sep 2024 12:24:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904102455.911642-1-nogikh@google.com>
Subject: Missing fix backports detected by syzbot
From: Aleksandr Nogikh <nogikh@google.com>
To: sashal@kernel.org, gregkh@linuxfoundation.org
Cc: dvyukov@google.com, stable@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

A number of commits were identified[1] by syzbot as non-backported
fixes for the fuzzer-detected findings in various Linux LTS trees.

[1] https://syzkaller.appspot.com/upstream/backports

Please consider backporting the following commits to LTS v6.1:
9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3 "Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm"
(fixes 9a8ec9e) 3dcaa192ac2159193bc6ab57bc5369dcb84edd8e "Bluetooth: SCO: fix sco_conn related locking and validity issues"
3f5424790d4377839093b68c12b130077a4e4510 "ext4: fix inode tree inconsistency caused by ENOMEM"
7b0151caf73a656b75b550e361648430233455a0 "KVM: x86: Remove WARN sanity check on hypervisor timer vs. UNINITIALIZED vCPU"
c2efd13a2ed4f29bf9ef14ac2fbb7474084655f8 "udf: Limit file size to 4TB"
4b827b3f305d1fcf837265f1e12acc22ee84327c "xfs: remove WARN when dquot cache insertion fails"

These were verified to apply cleanly on top of v6.1.107 and to
build/boot.

The following commits to LTS v5.15:
8216776ccff6fcd40e3fdaa109aa4150ebe760b3 "ext4: reject casefold inode flag without casefold feature"
c2efd13a2ed4f29bf9ef14ac2fbb7474084655f8 "udf: Limit file size to 4TB"

These were verified to apply cleanly on top of v5.15.165 and to
build/boot.

The following commits to LTS v5.10:
04e568a3b31cfbd545c04c8bfc35c20e5ccfce0f "ext4: handle redirtying in ext4_bio_write_page()"
2a1fc7dc36260fbe74b6ca29dc6d9088194a2115 "KVM: x86: Suppress MMIO that is triggered during task switch emulation"
2454ad83b90afbc6ed2c22ec1310b624c40bf0d3 "fs: Restrict lock_two_nondirectories() to non-directory inodes"
(fixes 2454ad) 33ab231f83cc12d0157711bbf84e180c3be7d7bc "fs: don't assume arguments are non-NULL"

These were verified to apply cleanly on top of v5.10.224 and to
build/boot.

There are also a lot of syzbot-detected fix commits that did not apply
cleanly, but the conflicts seem to be quite straightforward to resolve
manually. Could you please share what the current process is with
respect to such fix patches? For example, are you sending emails
asking developers to adjust the non-applied patch (if they want), or
is it the other way around -- you expect the authors to be proactive
and send the adjusted patch versions themselves?

Some sample commits, which failed to apply to v6.1.107:
ff91059932401894e6c86341915615c5eb0eca48 "bpf, sockmap: Prevent lock inversion deadlock in map delete elem"
f8f210dc84709804c9f952297f2bfafa6ea6b4bd "btrfs: calculate the right space for delayed refs when updating global reserve"

-- 
Aleksandr

