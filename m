Return-Path: <stable+bounces-213072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIKNCXK0gGl3AgMAu9opvQ
	(envelope-from <stable+bounces-213072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 15:28:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FCCD577
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 15:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC5FB301FC8B
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30036A020;
	Mon,  2 Feb 2026 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYUpgPVM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD761A76DE
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042472; cv=none; b=DkWQ7BInWv35I1GE5tgkB7KQSJRPG39xQhrRKdaLvYBgB4BTvwRA2PWi/W8WSLT5Hxchea9E7DVZa7P79iVrHaPVIGBjI+Jghc6N8pidQK25ID8Gg3ntXnO6LwFdAXfx74NA+RuFHyXWtPTEb9C4hgpWJkr9/GrIlGsgUCRqVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042472; c=relaxed/simple;
	bh=ho25507JT5SprOFZDqDIxW0RwscndtKQanGMBjy+ic8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STVdTou7KVbk6BInIoFiumyNpBi80hgyZg4h3G7ywyh5EjXlA4pp7yxRN9rFKOYXfJKryBiv/SjXYXt5pV2QKavkClsDqFAjOJ/H88PkJBwIGZUJYN1JuOP/GFf2fvuYY2Es2xM954+/7QQ3H/Q1rydy8tZHceLzTkWnPkjpi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYUpgPVM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d256c2e6so3670782f8f.3
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 06:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770042469; x=1770647269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa53JigECELRg73Adms37S5X9UGHUyeAQSVpcCaJ1xk=;
        b=WYUpgPVMkoqeQuA0P0SzGadXhp3kDEJ01pi1RhLxd8LICrDeDauVvySbyn0XSe/odp
         BlZjbufPvjKH8qStl+pwT/wOmwAgoh3jK+ebx4ELv2f/Xvb2URoobquvkaCRDFcdropg
         V62rI74t77/yux6EOEMrtKe6ilVfpErWXVY//5KqdrKpE4Rl+khmnnBxtjH+ta/MnG0L
         RwsB/KgapGbQBPWCOoTl1eT1TYJN/BAcA04yxDM9i8ocranQJH9js1axA4FTCWCh5rOg
         iW1NVBffgQRxk6x5fhskKZMGb2LFC7tnUAOnD03FqV1gX2V0eAYdqYuaAwNQ97P5rL+N
         92hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770042469; x=1770647269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oa53JigECELRg73Adms37S5X9UGHUyeAQSVpcCaJ1xk=;
        b=UI0nmTIQnM9rGcsMi1dt6tWysF9r6TiooDtloV1FlKeLdnpmGD5MPnbYwuIggeliSB
         c+KHHnK2vicHM/kboQR/AY4n01tC7oIhCJTJRkiBhPae44kpaKqiHTiwI3kLoZYN4lgO
         mA4EyJzBOXcP96hYHc+oVM9xS6RfWakD/89hoGaeRjg2Z1ExmC7K5CBbXdBO21Hp1L9s
         1kwu0l2HS2gusHPoMcJzeaLPh3mho/EdBsNSjp3By2mVZ+VSBSYqwegt+H0DgBvikbgR
         aJdK3rr1uz8X/1H7SS5Ts54srq+mQbOpmf4vULQ6Y7eHY5JFuaxf2kIg1r9r718NqDky
         yPOA==
X-Forwarded-Encrypted: i=1; AJvYcCUIueJtad6FwEaJCqibXFvTmVQqbeD1xa6BE/vkBSPb4GPcyaLOKr9EgjL4OVVfq82h6DI2ynE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPU+a7+JF2trvh/8rkMtg9sIkUy1s/gWFcYtxwhk0T+pNit82r
	1Ge5oKfbS7t9NJC+Y6JpJfE5ksKuwTbZy8D0hplEvaMkegP/yKjGVfGi
X-Gm-Gg: AZuq6aLXatDr5idKCoaA0KYMAXxzNvfTkBTlHyh9XPYQ6uMG4cOpF2g3g8pLNJ8TZl9
	3JP4pyrFnHinP21qBeRS81SUhBgdjbP7Po6ehEwC1rSw6x7syotpTF6XxjZZPkCAS1wyM0vg23C
	c+HFCgxODQkxmobVdaPo76sq+iHBFa+EbPCgAF8tAP2+AdEugSCwMWZz51mLIt2/N36wsm8Mdq0
	2V9ZYw6xdgUFesgqv0yimsPZZ4NwqwCVGyem7oGGGDUn2i5nUIpyA+l0+vhd004aaGkARJGjg86
	wNdVqg0GWaAGA4QrAV0LXdvp3CB3d7/U16mhD83sj3lN64yNpDUMaburPlQGKurd4+n4GofIob6
	seg/bXiDKCQj3KPNG9zbMgSpqET7IaxG08R10ckbsIFNTOF1i73EMZaZdGvSGCTnrkOgkn0S4JU
	QUjr4fF28=
X-Received: by 2002:a05:6000:4313:b0:435:9ee1:f91a with SMTP id ffacd0b85a97d-435f3abc95amr19088406f8f.53.1770042468789;
        Mon, 02 Feb 2026 06:27:48 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435e10ee057sm49297025f8f.15.2026.02.02.06.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:27:48 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	lennart@poettering.net,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl,
	Menglong Dong <dong.menglong@zte.com.cn>,
	Zhang Yunkai <zhang.yunkai@zte.com.cn>,
	cgel.zte@gmail.com,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
Date: Mon,  2 Feb 2026 17:27:32 +0300
Message-ID: <20260202142732.2207674-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213072-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,toxicpanda.com,poettering.net,vger.kernel.org,zeniv.linux.org.uk,in.waw.pl,zte.com.cn];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 992FCCD577
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> Currently pivot_root() doesn't work on the real rootfs because it
> cannot be unmounted. Userspace has to do a recursive removal of the
> initramfs contents manually before continuing the boot.

I want to point out at yet another benefit of this nullfs patchset:
it prevents data loss on external devices.

Here is why:
https://lore.kernel.org/all/20210522113155.244796-3-dong.menglong@zte.com.cn/
(search for phrase "data lose arise").

-- 
Askar Safin

