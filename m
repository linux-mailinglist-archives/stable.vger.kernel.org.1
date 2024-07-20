Return-Path: <stable+bounces-60642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3F093824E
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A50C1F21502
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1F7145B38;
	Sat, 20 Jul 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iP1FWdw+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B412FF70
	for <stable@vger.kernel.org>; Sat, 20 Jul 2024 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496949; cv=none; b=KdL84zWKY2F9LDg/IoMukckdMj+/dLyA9BjxpI+RwYU5P8w4q6VG7hpf1mkxuo6Q9RYIUc6KnG0NajJ0bg5cM633GAiU4fgwOS6gVECQc4f9MCpE0/tTI5kee8KV/qDuPScst4LVfjhD+47USZzaGmMmqVuFAxMnLwbAZZ2bb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496949; c=relaxed/simple;
	bh=LvRSHwLdgeGqyQRCJRuAKoBoowAcwZfAq3RdDO2MjII=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K7dgGvxvffepwOTXjxDi/AZwMSkBAlr5/6p/TtbNcNmVJnQc8TDIMPBTINQ9zQBQNqtfzFtCvHHpKIFCDnIQmI7bpwB3yzcVZNRIQSQ5k5oCBf9Y2LkAMIMKjg4txN+7XxBDOAPs99/EekyhUg79x9ZDbykwalKKhBjYLdagfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jglisse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iP1FWdw+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jglisse.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso6829279276.1
        for <stable@vger.kernel.org>; Sat, 20 Jul 2024 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721496946; x=1722101746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSTDR4P/Fbj8rjRW35CmYmprz89sVj3I9HRlwsNtEQw=;
        b=iP1FWdw+vsA89XCJm27Tkf/0pvllo8VsxxmZztBmhcbQLk7eXpIZhvh2Rbc3+dq7QY
         M/WmljA7Bpj6z3MiBxoSJikfd5Lvb11gM+ZmMHrMY1sNdRwLoobtem647zGvk4JoPhNX
         pyRPSluUafEtQRj4TMji1GFYIekxfH2J8Y88n+KzH8ug3I1vMfSnoXtVGE648/isrALN
         Xq74xVGS2ItqomttHU9C2/IerJc4k4uJV3n/BqqthsWaiuclcaCkinC4gnyZULMOiQiE
         UjyfQ4m1zRzgEDE/eELnvliwkqk0Z+1OyNkuJtQ5hOgfW27y5F3O8d8gmGKHxGilTiWh
         msbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721496946; x=1722101746;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSTDR4P/Fbj8rjRW35CmYmprz89sVj3I9HRlwsNtEQw=;
        b=epKdiSC/OZJmW7RhNm5yKAk0kI+2U6G0gTsGeNwCy2iWfUYmu+xH/pjRMQ0T7P44n7
         S/N1oUuc5Gs6o8+jBhG7InotCwcOi6pv9Dr6FUwZrMJHSSH/2KexHvsVPOFh4PcNT4ex
         i8blmwpufLuiIAIU2PH/HiMT9/6dJS4ozG5QCwI8WC8WPuIAM9LuBJK7Bw7AfrpVpURf
         U+/IRQ0vpXr7wQMir1+IEXpzMve+8KLtW56qB/1yDx6v6mIs6hC5lZNr4CacHfu4UAmy
         a6F3kdjriWWNNJ9oIe0qgQKD3oW8enry/WBxmRO1n5JVMaq8tlbxI6BSqINUaXEt90+A
         u1pw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2yacx3WmmnkYiKJWCITFyfGqMT63zacsWMlSwnzFBwYs1+8m1aLEI/GaR/xWlE447WsOmijPfCyCgME4rreVm2JysB/u
X-Gm-Message-State: AOJu0Yxeu+f+pUGhZcsUGBuLLEDcZIpHIa9N7Q9oEy6AELy8jutY+JEB
	2uRJ4tksmR5PrIKIKMQhOiRQ2Yy4IHW6I+cCzUKTbZbgZC6ZsZYiLSOUAUs0LgYVhc4gRsAhclK
	WFKDdug==
X-Google-Smtp-Source: AGHT+IHzHGE+4Mf1AVi4KXPPKK23kOipnaPWrS8JnK0Wo6p7UpxnYoWF5JzEWZ4ozvZkdPd2aV+vcVPXamGR
X-Received: from jglisse-desktop.svl.corp.google.com ([2620:15c:2a3:200:5d5c:1221:33d8:1aa1])
 (user=jglisse job=sendgmr) by 2002:a05:6902:1109:b0:e02:5b08:d3a with SMTP id
 3f1490d57ef6-e086fcb109emr25253276.0.1721496946462; Sat, 20 Jul 2024 10:35:46
 -0700 (PDT)
Date: Sat, 20 Jul 2024 10:35:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240720173543.897972-1-jglisse@google.com>
Subject: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and migrate_pages()
From: Jerome Glisse <jglisse@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Jerome Glisse <jglisse@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because maxnode bug there is no way to bind or migrate_pages to the
last node in multi-node NUMA system unless you lie about maxnodes
when making the mbind, set_mempolicy or migrate_pages syscall.

Manpage for those syscall describe maxnodes as the number of bits in
the node bitmap ("bit mask of nodes containing up to maxnode bits").
Thus if maxnode is n then we expect to have a n bit(s) bitmap which
means that the mask of valid bits is ((1 << n) - 1). The get_nodes()
decrement lead to the mask being ((1 << (n - 1)) - 1).

The three syscalls use a common helper get_nodes() and first things
this helper do is decrement maxnode by 1 which leads to using n-1 bits
in the provided mask of nodes (see get_bitmap() an helper function to
get_nodes()).

The lead to two bugs, either the last node in the bitmap provided will
not be use in either of the three syscalls, or the syscalls will error
out and return EINVAL if the only bit set in the bitmap was the last
bit in the mask of nodes (which is ignored because of the bug and an
empty mask of nodes is an invalid argument).

I am surprised this bug was never caught ... it has been in the kernel
since forever.

People can use the following function to detect if the kernel has the
bug:

bool kernel_has_maxnodes_bug(void)
{
    unsigned long nodemask =3D 1;
    bool has_bug;
    long res;

    res =3D set_mempolicy(MPOL_BIND, &nodemask, 1);
    has_bug =3D res && (errno =3D=3D EINVAL);
    set_mempolicy(MPOL_DEFAULT, NULL, 0);
    return has_bug;
}

You can tested with any of the three program below:

gcc mbind.c -o mbind -lnuma
gcc set_mempolicy.c -o set_mempolicy -lnuma
gcc migrate_pages.c -o migrate_pages -lnuma

First argument is maxnode, second argument is the bit index to set in
the mask of node (0 set the first bit, 1 the second bit, ...).

./mbind 2 1 & sleep 2 && numastat -n -p `pidof mbind` && fg
./set_mempolicy 2 1 & sleep 2 && numastat -n -p `pidof set_mempolicy` && fg
./migrate_pages 2 1 & sleep 2 && numastat -n -p `pidof migrate_pages` && fg

mbind.c %< ----------------------------------------------------------

void *anon_mem(size_t size)
{
    void *ret;

    ret =3D mmap(NULL, size, PROT_READ|
               PROT_WRITE, MAP_PRIVATE|
               MAP_ANON, -1, 0);
    return ret =3D=3D MAP_FAILED ? NULL : ret;
}

unsigned long mround(unsigned long v, unsigned long m)
{
    if (m =3D=3D 0) {
        return v;
    }

    return v + m - (v % m);
}

void bitmap_set(void *_bitmap, unsigned long b)
{
    uint8_t *bitmap =3D _bitmap;

    bitmap[b >> 3] |=3D (1 << (b & 7));
}

int main(int argc, char *argv[])
{
    unsigned long *nodemask, maxnode, node, i;
    size_t bytes;
    int8_t *mem;
    long res;

    if (argv[1] =3D=3D NULL || argv[2] =3D=3D NULL) {
        printf("missing argument: %s maxnodes node\n", argv[0]);
        return -1;
    }
    maxnode =3D atoi(argv[1]);
    node =3D atoi(argv[2]);

    bytes =3D mround(mround(maxnode, 8) >> 3,
                   sizeof(unsigned long));
    nodemask =3D calloc(bytes, 1);
    mem =3D anon_mem(NPAGES << 12);
    if (!mem || !nodemask) {
        return -1;
    }

    // Try to bind memory to node
    bitmap_set(nodemask, node);
    res =3D mbind(mem, NPAGES << 12, MPOL_BIND,
                nodemask, maxnode, 0);
    if (res) {
        printf("mbind(mem, NPAGES << 12, MPOL_BIND, "
               "nodemask, %d, 0) failed with %d\n",
               maxnode, errno);
        return -1;
    }

    // Write something to breakup from the zero page
    for (unsigned i =3D 0; i < NPAGES; i++) {
        mem[i << 12] =3D i + 1;
    }

    // Allow numastats to gather statistics
    getchar();

    return 0;
}

set_mempolicy %< ----------------------------------------------------

void *anon_mem(size_t size)
{
    void *ret;

    ret =3D mmap(NULL, size, PROT_READ|
               PROT_WRITE, MAP_PRIVATE|
               MAP_ANON, -1, 0);
    return ret =3D=3D MAP_FAILED ? NULL : ret;
}

unsigned long mround(unsigned long v, unsigned long m)
{
    if (m =3D=3D 0) {
        return v;
    }

    return v + m - (v % m);
}

void bitmap_set(void *_bitmap, unsigned long b)
{
    uint8_t *bitmap =3D _bitmap;

    bitmap[b >> 3] |=3D (1 << (b & 7));
}

int main(int argc, char *argv[])
{
    unsigned long *nodemask, maxnode, node, i;
    size_t bytes;
    int8_t *mem;
    long res;

    if (argv[1] =3D=3D NULL || argv[2] =3D=3D NULL) {
        printf("missing argument: %s maxnodes node\n", argv[0]);
        return -1;
    }
    maxnode =3D atoi(argv[1]);
    node =3D atoi(argv[2]);

    // bind memory to node 0 ...
    i =3D 1;
    res =3D set_mempolicy(MPOL_BIND, i, 2);
    if (res) {
        printf("set_mempolicy(MPOL_BIND, []=3D1, %d) "
               "failed with %d\n", maxnode, errno);
        return -1;
    }

    bytes =3D mround(mround(maxnode, 8) >> 3,
                   sizeof(unsigned long));
    nodemask =3D calloc(bytes, 1);
    mem =3D anon_mem(NPAGES << 12);
    if (!mem || !nodemask) {
        return -1;
    }

    // Try to bind memory to node
    bitmap_set(nodemask, node);
    res =3D set_mempolicy(MPOL_BIND, nodemask, maxnode);
    if (res) {
        printf("set_mempolicy(MPOL_BIND, nodemask, %d) "
               "failed with %d\n", maxnode, errno);
        return -1;
    }

    // Write something to breakup from the zero page
    for (unsigned i =3D 0; i < NPAGES; i++) {
        mem[i << 12] =3D i + 1;
    }

    // Allow numastats to gather statistics
    getchar();

    return 0;
}

migrate_pages %< ----------------------------------------------------

void *anon_mem(size_t size)
{
    void *ret;

    ret =3D mmap(NULL, size, PROT_READ|
               PROT_WRITE, MAP_PRIVATE|
               MAP_ANON, -1, 0);
    return ret =3D=3D MAP_FAILED ? NULL : ret;
}

unsigned long mround(unsigned long v, unsigned long m)
{
    if (m =3D=3D 0) {
        return v;
    }

    return v + m - (v % m);
}

void bitmap_set(void *_bitmap, unsigned long b)
{
    uint8_t *bitmap =3D _bitmap;

    bitmap[b >> 3] |=3D (1 << (b & 7));
}

int main(int argc, char *argv[])
{
    unsigned long *old_nodes, *new_nodes, maxnode, node, i;
    size_t bytes;
    int8_t *mem;
    long res;

    if (argv[1] =3D=3D NULL || argv[2] =3D=3D NULL) {
        printf("missing argument: %s maxnodes node\n", argv[0]);
        return -1;
    }
    maxnode =3D atoi(argv[1]);
    node =3D atoi(argv[2]);

    // bind memory to node 0 ...
    i =3D 1;
    res =3D set_mempolicy(MPOL_BIND, &i, 2);
    if (res) {
        printf("set_mempolicy(MPOL_BIND, []=3D1, %d) "
               "failed with %d\n", maxnode, errno);
        return -1;
    }

    bytes =3D mround(mround(maxnode, 8) >> 3,
                   sizeof(unsigned long));
    old_nodes =3D calloc(bytes, 1);
    new_nodes =3D calloc(bytes, 1);
    mem =3D anon_mem(NPAGES << 12);
    if (!mem || !new_nodes || !old_nodes) {
        return -1;
    }

    // Write something to breakup from the zero page
    for (unsigned i =3D 0; i < NPAGES; i++) {
        mem[i << 12] =3D i + 1;
    }

    // Try to bind memory to node
    bitmap_set(old_nodes, 0);
    bitmap_set(new_nodes, node);
    res =3D migrate_pages(getpid(), maxnode,
                        old_nodes, new_nodes);
    if (res) {
        printf("migrate_pages(pid, %d, old_nodes, "
               "new_nodes) failed with %d\n",
               maxnode, errno);
        return -1;
    }

    // Allow numastats to gather statistics
    getchar();

    return 0;
}

Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 mm/mempolicy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index aec756ae5637..658e5366d266 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1434,7 +1434,6 @@ static int get_bitmap(unsigned long *mask, const unsi=
gned long __user *nmask,
 static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 		     unsigned long maxnode)
 {
-	--maxnode;
 	nodes_clear(*nodes);
 	if (maxnode =3D=3D 0 || !nmask)
 		return 0;
--=20
2.45.2.1089.g2a221341d9-goog


