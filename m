Return-Path: <stable+bounces-230406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FRuB+eNxGkh0gQAu9opvQ
	(envelope-from <stable+bounces-230406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:37:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39732DF5C
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 327FE304804E
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8E38F252;
	Thu, 26 Mar 2026 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPzxCEBd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8316F288
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489057; cv=none; b=AEcrG9lYY6/Y+g2CzLBua3XBSJuH0NQFjIOKe7HhZkhKpbnT/Ss8Jx5foBHVpX62PJH/xmmywjWt158BMKkXPS11j2KJNf3G82yGoZaa2+/qZYPJYEtvQ9GkJH3F+lLtTXRaOGxtN8FM+McB+nSIWL7jMI71DuBGS6ZiI4pqvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489057; c=relaxed/simple;
	bh=Jj2qm8qG63CrbIFMV9IlMuOzVORLnHETDXVgtmwwQxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXc8lb7MjVhy/1bHE+1xOgYwUX1UP74RNAOdVtJdGwr4N2Envq61IBCCFYiYWR13bsnrxDt36v9ETyhrJE8wxrSWHzyLLwLIt11E88KqxLfvOLI0o9s+zEnxVxyw5YVaRShIVAy7rgTaotgds9jAWFJJ811xhbaYJ0mpoB/JksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPzxCEBd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829ac4670c4so362173b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 18:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774489055; x=1775093855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAPOHm+2rdklVBQSpRSKOLEhOKAWiuPin4IyJcaEptM=;
        b=lPzxCEBdmqkipI9rRiylIAI9Pm8f+9DbddUXdmriv4csOgioReWznr1cTmg8xKFm4g
         bH+kF1HTdylg2fbDUzuFYv4TC8BHxa9i3vxTOGoHOtPy+//jycwQ05UiEuGehqqHQ1Qc
         E4BO1TJblnfZJbUiSrw8YukQXisZUv6jCtdSjow5iV5sHoHnrxDPWdk4SkefTEm34lpg
         o5C+Roc981IZboV+bQzjCBmVyFh2UcJ9XIBKLF07nfgPlGZ7xnbS7pdthZa0ZpMffd3A
         /PMx50RQx+EIihthMivVSrx+l0EtH5xh0+eGnbH1BNGY/LjQewPOeIuoOemdwD2tsgMb
         irgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774489055; x=1775093855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAPOHm+2rdklVBQSpRSKOLEhOKAWiuPin4IyJcaEptM=;
        b=TrIFJGzi9vZ9gPIWV6l3rzTMQ2aDZJ6hJ7/KmJor7N2zIKRziq8qR4PbLLF6iIrG8E
         li0s+i0ISvdCTMR2fEf/dyv/LBSMybKrP5k8RVngPS0eBzJrptygWDxduc3kG1gAvVeU
         cf4AqxOC5AabICP8Tg7TnsNFXVD/I0TM2K19y0HxUIrOvRae2RIj1bkCb1OPEfbK70gw
         B+a6fG+EJxC1xhr0enO6nBWoXKzMlMFSeFcusBg1iIj+BrAxNvLgShfg7u4e2MjnQLXI
         rqWFWaTXqXiy4xu7OY67gi4bHUA8kRf05bNonVzO8CttUvx2KbXASZWvkvL0NeWq8t8M
         P8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXm7H0fr70ayezgYgfrF4x5EPX9npAizi4iTXWR0vAdMhCch+rgaVKoVLxMC4n0mDC9DWH/WQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV1I6l8m96ki1oLuGtkfOr2ppqX6jsgQDLRSFhWzFyrPdIqd51
	TjoQZF2TsT/T7Htfq/+Xaek/a18/AG97MWU05kjNakiFdeM6DAlBkoi0tQgzM3bA4pk=
X-Gm-Gg: ATEYQzxXyM6eLGjo3U5mNPIL3z6tJfe1YSyF1CPWdwSpGbB/wRVmhaY7ijOBVdfcPDz
	7PB58fpv7TMiRUmYD9yRH7uc7VyMLTl61tcocckBBUHcGcLR7jNLSZx4mF0EsA50uas9iRI3ww+
	K50tmA6Jef80s7GqMHY8uWNpqBLuH9HmnYWXPkGB0pvqGgqP4g7TbO5e8x2Frsaze40/ShQstRh
	kfyrExS55zwW0xv+4AH01uY4uh07ckxrZpoGGSxUF/CHTfEBMrfEYmqbF2u3DiQrHCNepYVSAjE
	ecBSYNiEQWaxO8Q/HSDriKrWNu7AT4DHNAgZ8GhqP+VY9StGTank70pU0Wmtc6MD2c/sQMHnS1j
	DNlivHhr9duQdxfri6ZMOMOcnnzRXkqeT8nV+ZDxAgjCMrcSbqjMx4Irar21R1HCF+CXAg8i1hg
	ybgeVZS0vvYYQr61I2+VFKrxQpx56mX1HPKHSquF1dBf1JI4UIW3X8C5FCgbpUuxt6NwqircE/c
	4G+
X-Received: by 2002:a05:6a00:2ea4:b0:82a:6e7f:4c14 with SMTP id d2e1a72fcca58-82c6df6609emr5412590b3a.27.1774489054556;
        Wed, 25 Mar 2026 18:37:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:820:e910:540f:de1e:bee1:7630])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d400f62sm883251b3a.55.2026.03.25.18.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 18:37:34 -0700 (PDT)
From: =?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
To: oscar.alfonso.diaz@gmail.com
Cc: fjhhz1997@gmail.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mac80211: fix the issue of NULL pointer access when deleting the virtual interface
Date: Thu, 26 Mar 2026 09:37:19 +0800
Message-ID: <20260326013719.1662-1-fjhhz1997@gmail.com>
X-Mailer: git-send-email 2.45.0.windows.1
In-Reply-To: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
References: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230406-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fjhhz1997@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D39732DF5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Óscar,

Lucid-Duck spent some time trying to reproduce your crash and wasn't able
to trigger it. Here's a summary of what was tested:

- Kali 2025.4 (kernel 6.18.12+kali-amd64) VM on QEMU/KVM, with my v2
  patch applied
- MT7921AU USB adapter, passthrough to VM
- Full airgeddon evil twin flow: monitor VIF + hostapd AP + continuous
  deauth via aireplay-ng
- Also tested on bare metal Fedora 6.19.8 with the same adapter

All tests were stable -- no crash, no dmesg errors, load stayed low. The
deauth frames were confirmed sending for 30+ seconds under the v2 patch
without issues.

The one variable that couldn't be matched was the VM hypervisor.
Lucid-Duck used QEMU/KVM, which handles USB passthrough at the kernel
level (xHCI). If you're using VirtualBox or VMware, the USB passthrough
path is quite different (userspace proxy), and that could potentially
explain a total VM freeze that isn't a kernel panic.

Could you please reply to Lucid-Duck directly on GitHub with the
following information? Here's the link:
https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4129198757

1. Which hypervisor are you using? (VirtualBox, VMware, QEMU/KVM, etc.)
2. Your exact USB adapter model and ID? (0e8d:7961 covers several
   MT7921 variants)
3. If possible, try SSHing into the VM from the host while the display
   is frozen -- if SSH still works, the issue is at the hypervisor/display
   level, not the kernel.

Thanks,
傅继晗

