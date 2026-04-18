Return-Path: <stable+bounces-238534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOA7NyfZ4mnB/AAAu9opvQ
	(envelope-from <stable+bounces-238534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:06:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE341F8F0
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4348D3055DD0
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF73175A9F;
	Sat, 18 Apr 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWmBFDe8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A2548EE
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474381; cv=pass; b=X9ExFywby71H+5kVF9rJta7c4RKkN5GrG7TKjMEWwDmAyvvMHsWsZhCFqZJo1VO1ndjxgHTuJ8RJ6nc1YtjxHzAN3FsJgwY+O30SVQgRHkwYAINhqXwIZOkIuxv9hJW163FgwqJVB7VKGTKWKtg9njTIWZubq9X+3CKr2+bsMZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474381; c=relaxed/simple;
	bh=MbJYuLV62yQM19c6dC9DtbHde8fn9mzXMYXm24tfU1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gcwl8gFaMNHOlTFUgf4DfOGK87wnGx+KyqfE0CB7jS8PSnQPGtZfo7JRPqbzrwYr1AQ92cWtphrFkzfTmqCES5OEzdRZGrTrDeQlUGkVxa9AZEMDHOmRR+c8diJNliRwkXwEWycWncAN8yJdpAq37hTq79FvyMaH0iNW6Vj/8/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWmBFDe8; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c55e3858cso3106170c88.0
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 18:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776474379; cv=none;
        d=google.com; s=arc-20240605;
        b=EqptgGCjNx6Dt2XkuDS6azkRJoJl3vGIxHfVzmZgj44FJls6Dh16+Gr0GMmuULLWZR
         A7G8McilcAe399xSHnwimlpdsZIYtmRBdX5bH8JrWudxnbSW46qxMsHDMgL0I1+glly1
         75T5H/dZTg/LCHrCP5C3m8YscAmphI7mIc2xTBwy2qXXMAAPWgmXNLwCUYpG8/p4joTO
         ijkBALI/6tHuorCyV7CLjqFVLHVOpKmwQSJcXT5oSK1GbDf9bMbbNTLNxCUNEiqRbeML
         7WXuiQfyE/ysevKWtRPTI25HrUWNoq2fDbrYUaW3iiCvmIQCnxYktqjbPOUV3XC3GCJZ
         RRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aJtzeCKdAvR+EBp3Q9RY8pglCClr3YzbEiQaHvpvF0E=;
        fh=6yCBCm6VJwx5jg87/6AvHf1BvuRaNc7VC/9WpKTpMR0=;
        b=JPSfAEmt/0TKhW/HuipDLCBQobY4/PT1J2R/sCuUhWM+zRd1dgpjxCWuQZ39Ci2kk+
         UaVFArty51lFLtM7hecJDmSZo9OGXvrmHmehsNH23fOT6lWb2wyhyZRhfIcMipxUbbOD
         maiPdPOKB6vdQuzVcgUYdUAbzoD4Ikr4pP7i6r2oxQiIqu1NR/bCd3owageZ/oqdJwQG
         OlGB8PvsdKCLsG0nREbM/mCjCIJANTIWJtfAmSFuFiYok8kTHExWv86KUtLLiAPmK/Z7
         e6WbJihqSNFFFpAvJXhUfcMBqvgpq6l2HRqV6Ok87GFu2WqU7HQ+FdYqf8eIsCYH8nqf
         ZDOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776474379; x=1777079179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJtzeCKdAvR+EBp3Q9RY8pglCClr3YzbEiQaHvpvF0E=;
        b=bWmBFDe8TPAgdIkqnhrI2L2M9JUCB2U/YmtNDhyhDwB4nFZoCpf0maWtZCXLyl9NVZ
         72L8icwvTEAU/sDwRvnO+tW74FOStnw1tUaKUHk6ewJR3a7lLmpV/ywVmBixwZ7al6pA
         1rAyB8DuIEFGNyDbUzIZR6cRLOky+rFEVWd0OLQxgv5x0hOjA0DK/JekuL49oTvTMvry
         8PNgd1+mxGMuEPXbK9kIwfNvK15kl5cNCxiMk/Y/WAEgxJ+ask2TOT654mP6ny08uHBV
         ukqAY4zJY4mYLc4pAFo2n/5O/IgMJdIHvAT6ePB7Nf1IX3ZXm+WvWNZzbyaLlre1DOh1
         8pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776474379; x=1777079179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJtzeCKdAvR+EBp3Q9RY8pglCClr3YzbEiQaHvpvF0E=;
        b=iA9gbA6LNISihibt6ce4ovMS49eOgdqjqVP3v7ZF+5cfBTjsDEuxJmYnsqEkD4nbp8
         ipyE9plBqUvzPrFzxE3VpjfzbtbayeekmJw1YzMpMkVc8N8zUjaMkskZV8DVjlU60tDw
         cCn78PJ22pyX8tQUUQmN1369VdtYmrVU5F3kam6234RnkhrspOPT12SlExTMEzEoa/UL
         avIchxweZLxW7UiSq3XnwK5c+XQaqryNLRUhuXfLwwnwtrDnmNclZyRrzHXY5RBAjZ7s
         WP1FNYkgAr0SIidSFaAhzlh7dS46+/RlOYABQAn1pojE7gLezeOC/aIygQcBrRyT3s18
         P4/A==
X-Gm-Message-State: AOJu0YzXAxRIfwWgvDx260aeVAGFAaOol/U1UXqh3YHbGOS3R6oOLpH7
	P7NSsySPv61eg0lrLTmE0OYkvk+RhK2+P02VhJraYXwW4710N4CIzOvZqnhBBPTTOsZzuZXtnGl
	G8YApranuQZ8eh7HS1c13vIRLzRpa4NbYdFUfuXRx
X-Gm-Gg: AeBDietdx7tKVWV5bjMMRm51qQYuDNx8x+hFElSlGhzBlaElZlBk8tmE8qEIy3t0VQy
	T80vguyqa6KJwzFxjxl7ADX/VT/LGKUGv8wM4t7d1Et9HHFQMPwuD1WEV63+ay5ZWhFgG6sV+Vy
	cw4IUJ1XxjO1csP1zwPjE2rMxTQ7nikLGM57eE4UyLk3Ydv1hEhELq9jrQUS5xddezU9dcFc0ZQ
	Dek7jbPL39tHtYKW4Iuz+iQHnfmKkKKoKHlyRmAbU7BHwHAmVrbsl/vFxKRIi60h6JMeZvW0dDB
	T/O6zha9r/jpV63RfKlGq3tGKsmIantgB9fAa8MqW2zQV5az4qU+4KXVMKq/4Rw8hj/A9q4WDs8
	6RiAwMSmNVy/0ex7tjx7+Uvoe36elN00Sc0alX7NmOMmX83zB/upj7FsuyWg9+ZJil2TZmY/ljw
	==
X-Received: by 2002:a05:7022:6085:b0:128:d7a7:5261 with SMTP id
 a92af1059eb24-12c73fa6408mr2590847c88.30.1776474378110; Fri, 17 Apr 2026
 18:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com> <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
In-Reply-To: <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 17 Apr 2026 18:06:06 -0700
X-Gm-Features: AQROBzAOzl4NDI37MDHb3Ki8sa2fZpf7yMu6HwGCVtU9lB0D-1xhB2T9BL_jaLE
Message-ID: <CAAVpQUDj13+MEz8HJTRyAcBYwUa6a2t7PNx_7qJRkjbihYk2Tg@mail.gmail.com>
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
To: "Ahmed, Aaron" <aarnahmd@amazon.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-238534-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,74.125.82.43:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65FE341F8F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 5:44=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Hi Aaron :)
>
> Thanks for the report.
>
> On Fri, Apr 17, 2026 at 5:20=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com=
> wrote:
> >
> > Hi,
> >
> > We have identified a TCP memory leak issue on Amazon Linux with kernel =
versions 5.15.168 through 6.18.20 that occurs when closing sockets with SO_=
LINGER set to l_onoff=3D1, l_linger=3D0, on servers handling many persisten=
t connections with full write buffers.
> >
> > Overview:
> >
> > The issue was discovered on a public-facing non-blocking TCP server tha=
t maintains many persistent connections and streams data to clients. When a=
 client cannot read fast enough, the TCP write socket buffer on the server =
side fills up and send() returns EAGAIN. At that point, the server applicat=
ion disconnects the slow client by setting SO_LINGER to l_onoff=3D1, l_ling=
er=3D0 and calling close(). This is intended to immediately reset the conne=
ction and release all associated kernel resources. However, while the socke=
t disappears from netstat and sockstat (TCP inuse drops), the write buffer =
memory is not properly reclaimed. /proc/net/sockstat shows TCP mem pages ac=
cumulating with no owning sockets, causing the leaked memory to grow past t=
he tcp_mem limits. Setting SO_LINGER to l_onoff=3D1, l_linger=3D1 instead d=
oes not leak. With l_linger=3D1, the connection goes through FIN_WAIT1 =E2=
=86=92 FIN_WAIT2 =E2=86=92 CLOSE (confirmed with BPF tcpstates), and all me=
mory is freed properly. With l_linger=3D0, the connection transitions direc=
tly from ESTABLISHED =E2=86=92 CLOSE via RST, bypassing the FIN states enti=
rely.
> >
> > Reproducer:
> > ```
> > /* tcp_linger_memleak.c - SO_LINGER(0) TCP memory leak reproducer
> >  *
> >  * Build:  gcc -O2 -o tcp_linger_memleak tcp_linger_memleak.c
> >  * Run:    sudo sysctl -w net.core.wmem_max=3D4194304
> >  *         sudo sysctl -w net.ipv4.tcp_rmem=3D"4096 8192 16384"
> >  *         ./tcp_linger_memleak
> >  */
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <unistd.h>
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <signal.h>
> > #include <sys/socket.h>
> > #include <sys/wait.h>
> > #include <netinet/in.h>
> >
> > #define NUM_CONNS 5000
> > #define PORT      6666
> >
> > static void print_mem(const char *label) {
> >     FILE *f;
> >     char line[256];
> >     f =3D fopen("/proc/meminfo", "r");
> >     while (fgets(line, sizeof(line), f))
> >         if (strncmp(line, "MemAvailable:", 13) =3D=3D 0)
> >             printf("%s: %s", label, line);
> >     fclose(f);
> >     f =3D fopen("/proc/net/sockstat", "r");
> >     while (fgets(line, sizeof(line), f))
> >         if (strncmp(line, "TCP:", 4) =3D=3D 0)
> >             printf("%s: %s", label, line);
> >     fclose(f);
> > }
> >
> > int main(void) {
> >     struct sockaddr_in addr =3D {
> >         .sin_family =3D AF_INET,
> >         .sin_port =3D htons(PORT),
> >         .sin_addr.s_addr =3D htonl(INADDR_LOOPBACK)
> >     };
> >     int opt =3D 1;
> >     signal(SIGPIPE, SIG_IGN);
> >
> >     int lsn =3D socket(AF_INET, SOCK_STREAM, 0);
> >     setsockopt(lsn, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
> >     bind(lsn, (struct sockaddr *)&addr, sizeof(addr));
> >     listen(lsn, NUM_CONNS);
> >
> >     /* Fork client: connect N times, never read */
> >     pid_t child =3D fork();
> >     if (child =3D=3D 0) {
> >         int fds[NUM_CONNS];
> >         for (int i =3D 0; i < NUM_CONNS; i++) {
> >             fds[i] =3D socket(AF_INET, SOCK_STREAM, 0);
> >             connect(fds[i], (struct sockaddr *)&addr, sizeof(addr));
> >         }
> >         pause(); /* sit forever, never read */
> >         _exit(0);
> >     }
> >
> >     /* Accept all connections */
> >     int clients[NUM_CONNS];
> >     for (int i =3D 0; i < NUM_CONNS; i++)
> >         clients[i] =3D accept(lsn, NULL, NULL);
> >
> >     /* Freeze client so it stops reading */
> >     kill(child, SIGSTOP);
> >     printf("=3D=3D=3D %d connections established, client frozen =3D=3D=
=3D\n", NUM_CONNS);
> >     print_mem("BEFORE");
> >
> >     /* Fill buffers and close with SO_LINGER(1,0) */
> >     char buf[2048];
> >     memset(buf, 'A', sizeof(buf));
> >     for (int i =3D 0; i < NUM_CONNS; i++) {
> >         int flags =3D fcntl(clients[i], F_GETFL, 0);
> >         fcntl(clients[i], F_SETFL, flags | O_NONBLOCK);
> >         while (send(clients[i], buf, sizeof(buf), MSG_NOSIGNAL) > 0);
> >         struct linger lg =3D { .l_onoff =3D 1, .l_linger =3D 0 };
> >         setsockopt(clients[i], SOL_SOCKET, SO_LINGER, &lg, sizeof(lg));
> >         close(clients[i]);
> >     }
> >
> >     sleep(2);
> >     printf("\n=3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=
=3D\n");
> >     print_mem("AFTER");
> >     kill(child, SIGKILL);
> >     waitpid(child, NULL, 0);
> >     close(lsn);
> >     return 0;
> > }
> > ```
> > Output (Tested on 6.18.20):
> > ```
> > =3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
> > BEFORE: MemAvailable:   95491288 kB
> > BEFORE: TCP: inuse 10005 orphan 0 tw 5 alloc 10006 mem 0
> >
> > =3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=3D
> > AFTER: MemAvailable:   95321800 kB
> > AFTER: TCP: inuse 5 orphan 0 tw 5 alloc 5006 mem 8300
> > ```
>
> Unfortunately, it dies immediately on my end.
>
> =3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
> Segmentation fault         (core dumped) ./linux/tcp_linger

This was due to small ulimit -n and fopen() returned
NULL being passed to fgets().

But I don't see any leak of memory nor counter after
the repro.

Note that the tcp_mem counter could be cached in
per-cpu counters, see proto_memory_pcpu_drain() etc.

---8<---
[root@fedora ~]# unshare -n
[root@fedora ~]# ip link set lo up
[root@fedora ~]# echo clear > /sys/kernel/debug/kmemleak
[root@fedora ~]# ulimit -n 100000 && ./linux/tcp_linger
=3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
BEFORE: MemAvailable:   54683048 kB
BEFORE: TCP: inuse 10001 orphan 0 tw 0 alloc 10008 mem 0
=3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=3D
AFTER: MemAvailable:   54616304 kB
AFTER: TCP: inuse 1 orphan 0 tw 0 alloc 5008 mem 3842
[root@fedora ~]# cat /proc/net/sockstat
sockets: used 0
TCP: inuse 0 orphan 0 tw 0 alloc 7 mem 0
UDP: inuse 0 mem 0
RAW: inuse 0
FRAG: inuse 0 memory 0
[root@fedora ~]# cat /proc/meminfo | grep Available
MemAvailable:   54732456 kB
[root@fedora ~]# echo scan > /sys/kernel/debug/kmemleak
[root@fedora ~]#
---8<---

