Return-Path: <stable+bounces-225446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFb8BA3BtWkA4wAAu9opvQ
	(envelope-from <stable+bounces-225446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 21:11:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6924728EB94
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 21:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57BB03034E27
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F67384225;
	Sat, 14 Mar 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrHU/i24"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CC34B19A
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519107; cv=pass; b=oersrmxtzY5RpK/9l2a5iuJEiGhRt4SU5scGNCaZ+nik+CW+vB6ciLplLfXavYu9CR7mM6INGz/hKGzSd3iAKu6e7w0Z5EFp330+tzqsjJzaszpjrtvEmr6XibF755CSbRCyZzwVIxvozjV8bs7CQzGfQg5FWOgPGG+6q50O3aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519107; c=relaxed/simple;
	bh=WkoXS075KSuaK6414fUI51pkZ2edKA0Qw+i5/cmums8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emhpN2nTpox3RNEnC3wadk4hi+NG4kSQS96StRSicpL5/50dzxdiOFpebToIYBCtKp5HoyujgzlX8ZkLTYsTiu2Ey3UQBYi8zQSusWTqhZO4oVBsrgNWL37AqIORkWmwFSoNOzjFrQBCamc45BQ1XbLjFrh2AuTk4UPW1hqZpjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrHU/i24; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5094ba0af1aso35207191cf.0
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 13:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773519105; cv=none;
        d=google.com; s=arc-20240605;
        b=giNvVARcWLWm/RlNAt+bTCUrcnw9UMMGOFXJtQ+JSqAI7/x381qBFYFsNUH+ZPp2fu
         f2gS4I3o/8jBGkEhhzxj3NWooMoy+kxGkbuFW/N+GtOmET7sLw55PUfRQIKMJOEpXqS/
         dkRujKAPBegJyUkhInH/DawIu/0NxK0MLHnCA81RbBMEL6AIyYRvWedjJZNVDuXlu8zD
         Dr7h55cGNBrOmUVLQ/gvagmzSU6yR1JoRw75DKT/puZV8kv0XNLyMBktyk31xnFZTpoq
         9YjfIrJyQ8JEBP443E/xob4i/+qlkIzZW8osq3zMizbr5+Pm4+AimC6PknppslJp1RCi
         hWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        fh=+TOAb2Q30joRoFg2xeft28WK21CGLvcNZWVdjlkNiC8=;
        b=UZ68n8Vd9uaIqvm3qRLbXjh88zRu33FjSy5JnmpdHNJJD58FTRJz/cjZEXBxdxWkLu
         n/2Q5USfCN4XIeU7a5Ne0Ub4mDPQaJ4XGH2Pw9ENaF41UWDANz11lVIyU8OWEta70BJt
         7Vef8FbrrYM36ra7ms1GsM2RrVNpjrq3VH3rwcOYhfzPR38iWKRF1hjjX4U9+oZLZ7hK
         Adx32mah1OtC3zky2H11QUgzGDYdMacVy++UvknjpK//BJgCUnAj/oLWg1w0LbLfXjzV
         R+1+gamwethkzxZM1skbJVGU3tbnKHzOR55CK8tFyP5w+rwGocfkwmaraYNWWUS0qGRo
         unsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773519105; x=1774123905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        b=SrHU/i24kV9sDpGMez2qT5mcAnJZfH+F35kTOj9W5AYf5xbPOMzYoMmxAplnd4OQ66
         +oeIeqaDn60RD1XwvjMSLPiAXwlppghAh9gjM/to8csuF7LMs1acC1KjMKo/xzfywOus
         sHr1zXqs1DHQ47XI/uE185qNrRqrnNDAgEzvQ+6jiQrbaaMeGKFBwLZEBrZ7khqpvRLj
         z9wJglrT5N43+zyqJ3FrF3Jp6FiKDtaTynm/WtQLPzmfsI9Yl8qMCD6mDviSiYwN6SxU
         0ndwAdykRAJkbxDr7Mr+NMXzAX1kMrUrTxtuJG+C1LVHcN6A7Ms+fVahpMVP1E35nU31
         XHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519105; x=1774123905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        b=Vn3OxgB7QMz97nFwljuiQy+c2NgrnzvoW4PsOd1hDdgwO0E7XnTPVyvQlIJOEuvFml
         f2Bf2kdKgp/sr0ILmRshyfs+LM60HxZuXgc8APdNMGXSOAnnq3AIl702uYkKnHgbs21q
         tNK2Eoq1+lSTvx6Bevk9mKPj/Qoc25ChJr4I57wNeBNRrXSC3ImZKM5wALa0rnWOF1CB
         r3V8mLfGy6obeNdjfPDnNjwXPGGuqz/U2YMsWI0aqsRzP35OMKZLv2Jma4kS3ymfy46E
         C6Yd9zbvS7wey5kI/X6YfMQHuwaWD1z0pxaBcE2YPg55l6Ol5N54DNfXPBaZRUsdcHP8
         TsPA==
X-Forwarded-Encrypted: i=1; AJvYcCUzuy3Pl4Lks0lGGbwk3M7rIsLxTjMwqXXjaQncNbZQmbPLoFuFPKYipVX52y6yQurHWlNcYI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8nePdsiFzlk1+Ou+WRfWddJUuwmxiNKwr0BbZpSZrg/odDO4
	algCx2rkIYC5GfJwhYlk+DWRHZ7NlFM1rAxYMnzE8597JA1sASkSP8Aj1HXpm8+f33rNm4TGJa6
	wy0shFNScGntb23IRNIn7O7l5DgiWKvYndYPNSECh
X-Gm-Gg: ATEYQzzTHkt17FS9aEq7EHHNngbQmX1+uiEzdw9Wn3qPnDLB+o91bJ7KEkzm5jwzzUn
	IlpUppHpPl2AuEYtDWL6hDO+VvdKNcC0T8AlnDYb99Ihqa3oP+nSN/VdjdMfm819151kdug7W+e
	Bka97r27JB/Yoeyk5AytIzq6D7MnUjyMqPH6oVUq8mYpnTcBhHJDyOj7N/N80zLt3aLGSAP1nF5
	zpGnKBR7c2oqctvYfm5Qg8VNdYR8fSIUG+E3ghYZI3i6a5GH0K95CZkTTFeqGNs4fw6l43aVsT4
	PA0rxCWq
X-Received: by 2002:a05:622a:1913:b0:509:1cf9:ea0e with SMTP id
 d75a77b69052e-50957e6d9ebmr106751231cf.41.1773519104360; Sat, 14 Mar 2026
 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312025406.15641-1-xietangxin@yeah.net> <20260314124017.59206dac@kernel.org>
In-Reply-To: <20260314124017.59206dac@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 21:11:33 +0100
X-Gm-Features: AaiRm51U9n8JmYbi4nsFyK5po3qG7vw7KdHuv209pKgETRH95O2uglDU7CC6gfk
Message-ID: <CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
To: Jakub Kicinski <kuba@kernel.org>
Cc: xietangxin <xietangxin@yeah.net>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225446-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[yeah.net,redhat.com,davemloft.net,lunn.ch,linux.alibaba.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yeah.net:email,cosmosbay.com:email]
X-Rspamd-Queue-Id: 6924728EB94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 8:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Mar 2026 10:54:06 +0800 xietangxin wrote:
> > Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside th=
e network namespace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: xietangxin <xietangxin@yeah.net>
>
> The Fixes tag should be:
>
> Fixes: 0287587884b1 ("net: better IFF_XMIT_DST_RELEASE support")

I disagree

What was the situation before this patch ?

I think virtio_net has been able to hold skbs way before
IFF_XMIT_DST_RELEASE has been invented.

Some archeology :

commit 93f154b594fe47e4a7e5358b309add449a046cd3
Author: Eric Dumazet <dada1@cosmosbay.com>
Date:   Mon May 18 22:19:19 2009 -0700

    net: release dst entry in dev_hard_start_xmit()

But really at that time struct dst_ops was not per netns

The bug came when each netns got a copy of "stuct dst_ops"

Not sure if 'fixing' virtio_net is enough. We really need to check all
other drivers that might hold skb with dst for more than an RCU grace
period.

Or... not count dst anymore. What is the point anyway ?

