Return-Path: <stable+bounces-238531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPtyFRLU4mm++wAAu9opvQ
	(envelope-from <stable+bounces-238531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 02:45:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B037741F7D8
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 02:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A12BF3057773
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FA255F2D;
	Sat, 18 Apr 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsVBjDgM"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84515245005
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473091; cv=pass; b=tckAFL/esaDoufwJ4Kij3kUUgpiA6hxnHCz0vtIM5xmWoX2Agz63UKnOrauL2XQ68BqPgB77el9UpZsx4QMXAr+crVpBOPILkhOargHvQ+qUZHrJVmoI5+OeNn2R9oZvhdkoEcrQuEVEb5uP+rz+hf533cShqlXF+XbRm5jvoyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473091; c=relaxed/simple;
	bh=QtkZKVzlWbC0y57YLALEats22IogWAhXWdiSPYN8m1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaWaNEZtey9aZaQNh2t7w2iglO4sP0BREwyOgFzIUg/srI2GnuZYvNpC33BIBqRXYw87QfS4zrxU9oEwUvmEyTv5qMRrVS5IvGmRzEXQgfcjwjwz5LrmXDQ6t57ed0fOMB6Qyh9O17oFNhACEuIn2nX3U35V4cUK5jcQ7PgncPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZsVBjDgM; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c565476d7so980871c88.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 17:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776473090; cv=none;
        d=google.com; s=arc-20240605;
        b=TVeR2NcyhWdPqjwCzoNJjZbehRuzwy7/GlBgu3/nGf8pWTNE/nrsJidMLZpsnBlL7Y
         NBzhNd1tSQg6OSoJsjbmdfil4qGirmSLvUdWDvjbKisxQz78LGloQNq3ypLfw3vY4fdT
         GMvNTPFgtYK5lH7S5cPBNYYbt2jlPqWofla+tbxjxoNyKN8tvlXKpyTObG6v8TP9Orcq
         G10fE5dNSQe0qRNxgUifw5Z0GAdI5LY18P4/ZOVELB3QLIQ0fREP9E4kF+k5h961gGQl
         re43B7yKLpd/nqNlrBfRiuEvhyC77EMCstx/eaImcqt4EUMqewwZmFworcdTWFmKdBB5
         mPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a0ywBDu1FJbk3C613F7iWgUPaLx2nZ37sXJ0DuoHjXk=;
        fh=6yCBCm6VJwx5jg87/6AvHf1BvuRaNc7VC/9WpKTpMR0=;
        b=eLKIx4mHwahvq9Wuvi6+qGUcBhvrFd1C1PQ214nbg7GZlTvVicxroMBDGGd4HQeU6T
         H6+xFqu9JhM/AQ3M/1KVS1PaqGnypSeyHzB4D3VAuy+FQTr8D71tjhkPPiZQxMPv2B+o
         CUNCMCfHW0t70AT7k+KhpJDaEZosnUrp9uWLx1VGnzSCyFA3oi7AUzld21KfczY0eFa9
         K3jRUl0T3GB49Fj+mL3guzi8idE1RBFwavfTECMlIXx4Yi9+Wv7POBmF7/65m5sl8HC2
         GIxVNhjvoqBysc0jcZCEC41tG2/yhFwt8W7WmW/WspmYqayLAOGSgkbLeGCmYG+Wp+zF
         wiIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776473090; x=1777077890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0ywBDu1FJbk3C613F7iWgUPaLx2nZ37sXJ0DuoHjXk=;
        b=ZsVBjDgMJCim2fcT/ZFyFFHoAktdahXayPcmASCRkx9KieLmxVORaWnhxn1ojLSor3
         3A+JWYRbQrhnCFLr0lMACoxG3mcMfJYsGotUvNtdYNpgTSdMRJPfavDkrni4FnuKVq1I
         qZIZMlWV1HdYHULFz8G9923ez3pH1xPba8tnO9Z/uA2YlbjoDE6APHynhJftGqdoh8g7
         6LijC5nzvw4chaoDqSR+U27GgIBZnNaK6ot7tzjc8HERz4G0eB/u1MU9hf9SjPRjrfxx
         T+gY4h/f0W1ASlYLVtT1tqVbnmONqEYEqo/lzZdX4RJ7jILedplC3fTJ2UTIBljkdWEa
         5cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776473090; x=1777077890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0ywBDu1FJbk3C613F7iWgUPaLx2nZ37sXJ0DuoHjXk=;
        b=lSzh4mHB6TcQWQIK632H3bYV81k4Rz41HTpsvLQqLKlavSWEGTyeaNoCaV4BUbu4tE
         qd5r/FHJ3VXeONOJZAqACJv/5/6jzaMx828bssq2e6QoLM87KuSFkNKyBMVPACi8tpRN
         UAn6S9fRG6Zfs9BnQ2lTWJRT+iBYEKpn6YLRsIj/52oPvw8J9sZ7jpb0rkwZ7ewxPsIj
         g4+r5z31ImeWcXlbVFwghDY8dn3LgonRpiFibJeU/fLenurcGXg3dBtkZfFd3Ix0b3SK
         QnlavT4UgZoXzv0C1VuRsJ6HufQ7RVwmsHVIlHD80j9YodRZnBMNkAu1ev5Qh1hrWjd+
         c8HQ==
X-Gm-Message-State: AOJu0YzyBzbGLmtKaKG9jZP+MVI+c0RGvKDi2S7KAQdFp/GJoNFMF3oA
	wf/3QGcqI+AxAFFgU4hXVcoKDbvpQ1yeqvwZQFDiI1krd2+yP3ABOeau0gUef0GGwPDqPvxpRuc
	RsxYJUTXJbUZNaZuM4Oc/HLu2o50ODqSyXCgg39VQ
X-Gm-Gg: AeBDietwPPREXNk83eunJ4xh5RtqiQmduzYO8CLNzXBXdk7e69aIHDhBAV/DpzTVFUN
	pOMK1hwvydlW4xWgjnuA9vXIdUtodL9ebs48yDWVmjYtxvgnEMexFJuTjBnmDeuHLkYg8NOVNTq
	NNxIKs5Qva/KR1qZ5AGBAkRJr8BvwcSYbkRoaSSDcLKqRCRsQFuGe59krU6jxkkL3bAFu1NENkY
	0LTRfrU3nh4ywnYWjazQNDKDU5Um5eewj/LtqXyLB7hVqvACSDdqtr2zPhd/jSxu96jrsRgXbrK
	Ma4vYWmeKa5DgOdVqe938jpB41bSpueNkS8pQqVRkZBFiaZuu3VcBt0d1ucX4wIcvaZu6w5/DoQ
	d60j9x727bmT18l6yu6KleRmcKi2naNluDUKDnosTEORebuuWfJ9GQ4WCVIuRZQgq2EUpbL5Izg
	==
X-Received: by 2002:a05:7022:eac8:b0:128:d386:4bbb with SMTP id
 a92af1059eb24-12c73f759d9mr2765683c88.13.1776473088895; Fri, 17 Apr 2026
 17:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
In-Reply-To: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 17 Apr 2026 17:44:37 -0700
X-Gm-Features: AQROBzBTrpaT_3MkHnlTRUTVuaFD829JUv0CkBtSfX3vhctL64YmC-K6VQWJpNA
Message-ID: <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238531-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B037741F7D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Aaron :)

Thanks for the report.

On Fri, Apr 17, 2026 at 5:20=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com> =
wrote:
>
> Hi,
>
> We have identified a TCP memory leak issue on Amazon Linux with kernel ve=
rsions 5.15.168 through 6.18.20 that occurs when closing sockets with SO_LI=
NGER set to l_onoff=3D1, l_linger=3D0, on servers handling many persistent =
connections with full write buffers.
>
> Overview:
>
> The issue was discovered on a public-facing non-blocking TCP server that =
maintains many persistent connections and streams data to clients. When a c=
lient cannot read fast enough, the TCP write socket buffer on the server si=
de fills up and send() returns EAGAIN. At that point, the server applicatio=
n disconnects the slow client by setting SO_LINGER to l_onoff=3D1, l_linger=
=3D0 and calling close(). This is intended to immediately reset the connect=
ion and release all associated kernel resources. However, while the socket =
disappears from netstat and sockstat (TCP inuse drops), the write buffer me=
mory is not properly reclaimed. /proc/net/sockstat shows TCP mem pages accu=
mulating with no owning sockets, causing the leaked memory to grow past the=
 tcp_mem limits. Setting SO_LINGER to l_onoff=3D1, l_linger=3D1 instead doe=
s not leak. With l_linger=3D1, the connection goes through FIN_WAIT1 =E2=86=
=92 FIN_WAIT2 =E2=86=92 CLOSE (confirmed with BPF tcpstates), and all memor=
y is freed properly. With l_linger=3D0, the connection transitions directly=
 from ESTABLISHED =E2=86=92 CLOSE via RST, bypassing the FIN states entirel=
y.
>
> Reproducer:
> ```
> /* tcp_linger_memleak.c - SO_LINGER(0) TCP memory leak reproducer
>  *
>  * Build:  gcc -O2 -o tcp_linger_memleak tcp_linger_memleak.c
>  * Run:    sudo sysctl -w net.core.wmem_max=3D4194304
>  *         sudo sysctl -w net.ipv4.tcp_rmem=3D"4096 8192 16384"
>  *         ./tcp_linger_memleak
>  */
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <sys/socket.h>
> #include <sys/wait.h>
> #include <netinet/in.h>
>
> #define NUM_CONNS 5000
> #define PORT      6666
>
> static void print_mem(const char *label) {
>     FILE *f;
>     char line[256];
>     f =3D fopen("/proc/meminfo", "r");
>     while (fgets(line, sizeof(line), f))
>         if (strncmp(line, "MemAvailable:", 13) =3D=3D 0)
>             printf("%s: %s", label, line);
>     fclose(f);
>     f =3D fopen("/proc/net/sockstat", "r");
>     while (fgets(line, sizeof(line), f))
>         if (strncmp(line, "TCP:", 4) =3D=3D 0)
>             printf("%s: %s", label, line);
>     fclose(f);
> }
>
> int main(void) {
>     struct sockaddr_in addr =3D {
>         .sin_family =3D AF_INET,
>         .sin_port =3D htons(PORT),
>         .sin_addr.s_addr =3D htonl(INADDR_LOOPBACK)
>     };
>     int opt =3D 1;
>     signal(SIGPIPE, SIG_IGN);
>
>     int lsn =3D socket(AF_INET, SOCK_STREAM, 0);
>     setsockopt(lsn, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
>     bind(lsn, (struct sockaddr *)&addr, sizeof(addr));
>     listen(lsn, NUM_CONNS);
>
>     /* Fork client: connect N times, never read */
>     pid_t child =3D fork();
>     if (child =3D=3D 0) {
>         int fds[NUM_CONNS];
>         for (int i =3D 0; i < NUM_CONNS; i++) {
>             fds[i] =3D socket(AF_INET, SOCK_STREAM, 0);
>             connect(fds[i], (struct sockaddr *)&addr, sizeof(addr));
>         }
>         pause(); /* sit forever, never read */
>         _exit(0);
>     }
>
>     /* Accept all connections */
>     int clients[NUM_CONNS];
>     for (int i =3D 0; i < NUM_CONNS; i++)
>         clients[i] =3D accept(lsn, NULL, NULL);
>
>     /* Freeze client so it stops reading */
>     kill(child, SIGSTOP);
>     printf("=3D=3D=3D %d connections established, client frozen =3D=3D=3D=
\n", NUM_CONNS);
>     print_mem("BEFORE");
>
>     /* Fill buffers and close with SO_LINGER(1,0) */
>     char buf[2048];
>     memset(buf, 'A', sizeof(buf));
>     for (int i =3D 0; i < NUM_CONNS; i++) {
>         int flags =3D fcntl(clients[i], F_GETFL, 0);
>         fcntl(clients[i], F_SETFL, flags | O_NONBLOCK);
>         while (send(clients[i], buf, sizeof(buf), MSG_NOSIGNAL) > 0);
>         struct linger lg =3D { .l_onoff =3D 1, .l_linger =3D 0 };
>         setsockopt(clients[i], SOL_SOCKET, SO_LINGER, &lg, sizeof(lg));
>         close(clients[i]);
>     }
>
>     sleep(2);
>     printf("\n=3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=3D\=
n");
>     print_mem("AFTER");
>     kill(child, SIGKILL);
>     waitpid(child, NULL, 0);
>     close(lsn);
>     return 0;
> }
> ```
> Output (Tested on 6.18.20):
> ```
> =3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
> BEFORE: MemAvailable:   95491288 kB
> BEFORE: TCP: inuse 10005 orphan 0 tw 5 alloc 10006 mem 0
>
> =3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=3D
> AFTER: MemAvailable:   95321800 kB
> AFTER: TCP: inuse 5 orphan 0 tw 5 alloc 5006 mem 8300
> ```

Unfortunately, it dies immediately on my end.

=3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
Segmentation fault         (core dumped) ./linux/tcp_linger


Did you see actual memory leak with kmemleak or is it
just the tcp_mem counter that is really leaked ?

# echo clear > /sys/kernel/debug/kmemleak
~ run repro ~
# echo scan > /sys/kernel/debug/kmemleak

