Return-Path: <stable+bounces-70231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F407C95F39B
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 16:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38246B20CA0
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45518891B;
	Mon, 26 Aug 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAfGCmWw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24043AA4;
	Mon, 26 Aug 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681428; cv=none; b=WOfXue3yMgb0rNUGY6ENZut6cLswcuWGnSqsOVWbroQQT5d3lSQaK7BCx0aCXYcuFTXkbrh4/qbkaW2a4PYEUghGPzpXMZa15UAJQZhCzO4qwwA2TXXt6uSfPi5luY4zEBxl3lmJE2r1ThgfQJUyKzZPXoEhBTB7ZoiwsjK+Dzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681428; c=relaxed/simple;
	bh=81dO0swR54vBtuFXEwtQzbV4rRGvMioDNMn0EXezWd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8orXxMYAE8/It++CttDxN76UiFm0dMOKjCHwvaj+JNUmiIz1Dk1cp+y5kw4zx4JokiZkextfih9Wu9tO2sCuqOzDMYJKUcQOoml/TjtV+fvOmveNGjICbwzyBQA/MWsy2Zlp5uSISTi5h20GARq8xEZuvnhbx2ZvpaEnkCLwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAfGCmWw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a83597ce5beso673691466b.1;
        Mon, 26 Aug 2024 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724681425; x=1725286225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laIxxNV89w8bBA1m8OYb4OYSHZUiQ+a2fQ2hNjVj8fM=;
        b=UAfGCmWwnJzEvtosaphXMnrCQVsxImRXr/k1K/xuPm0SI7a+q75qdUeMpB0AfTQ3UF
         ABHpUx+qTK3//4BwG528pqlGUD4r08J9OOL59uE225S7OIi7TDWz15T8AIW63CZr3WZw
         rMOrtf43vpyFtNMU6iufngIJyJohtX6fpOFiLPomSmfsht1JDsS2ErcCF3IQvB7ITvpQ
         iw9eBCihD+Ov895zC79V0GP/I+6vPvj4YFi2p+ndgJsOvdSyzvfG6TlFJLTjUgzz9Gt8
         yZ1ueHAYmwXJvqhgFTo64X8P+6PTrGF9VmYrOzKqF/tLfQgM1Z1aTB4HxXv+gBoGFu4+
         OcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681425; x=1725286225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laIxxNV89w8bBA1m8OYb4OYSHZUiQ+a2fQ2hNjVj8fM=;
        b=B5ef207l20tVtXmyuC9d2hnRtQAXj3yl40w+ruOPfAu8Rf8qg4tdgRTs0oK76N87et
         KI6aYhbRCOLlDTcqFMiWe9MJNnR2ru3OyBwCmJjomFE3VZaImo3yEo5AO90TDId5tfvZ
         lJbi2sKHjoeyGGTs7n/xrXwY29DdHcwE4ExrR5r89qyxUWqs4HoEaQV7X0UIcc6zaScB
         5H4aWPC8f3sV5d/HglLKlKcpH9TQ+4xIkRzxvZgQggIQVdHjSkm3uQrHg5i7jo4oUfTb
         06zM+mvSVutLvMzxh27NBu7ky1HvmNQ+gRSl8Ec94RphltbcrvvOmjOaX4ZCBuPWLvg3
         5DIg==
X-Forwarded-Encrypted: i=1; AJvYcCU6chmCKPHvcdK+NVvCks/JcpfYxBSgiocUtvLjjvn6+dGMX8rRBPSx1LWBOrZZJaou1/jywaL/@vger.kernel.org, AJvYcCUFDa4+4r18Kn1Qsfu4hvE2pk9Fo0eyawhsvHcrBF7zZTDcJTehKrOZzaX1MqwX8GlUilLDzag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrdG4QuxqzPMzopdQn81iWMBfQdJzpHInuCIRyW55cUnXvlgX
	PgeZMTDATXCXhj/iXDeGBAAVpYw1AXIMrvcMt0YK0BhOmaUF0c2G
X-Google-Smtp-Source: AGHT+IGWQN0ylENMl/qg2kzZRH6WH2UcyKB7f68IOf475cLgnm+b8N8DD7/zB/vCEdym1uqfLCclyA==
X-Received: by 2002:a17:907:6ea7:b0:a6f:996f:23ea with SMTP id a640c23a62f3a-a86a2fa1d02mr1201115366b.15.1724681425079;
        Mon, 26 Aug 2024 07:10:25 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f22053dsm675939166b.31.2024.08.26.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:10:22 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id CC316BE2EE7; Mon, 26 Aug 2024 16:10:21 +0200 (CEST)
Date: Mon, 26 Aug 2024 16:10:21 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vitaly Chikunov <vt@altlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	Adrian Vladu <avladu@cloudbasesolutions.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"arefev@swemel.ru" <arefev@swemel.ru>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"willemb@google.com" <willemb@google.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	David =?iso-8859-1?Q?Pr=E9vot?= <taffit@debian.org>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <ZsyMzW-4ee_U8NoX@eldamar.lan>
References: <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
 <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
 <20240814055408-mutt-send-email-mst@kernel.org>
 <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
 <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <ad4d96b7-d033-4292-86df-91b8d7b427c4@heusel.eu>
 <66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch>
 <zkpazbrdirbgp6xgrd54urzjv2b5o3gjfubj6hi673uf35aep3@hrqxcdd7vj5c>
 <66c5f41884850_da1e7294d2@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66c5f41884850_da1e7294d2@willemb.c.googlers.com.notmuch>

Hi,

On Wed, Aug 21, 2024 at 10:05:12AM -0400, Willem de Bruijn wrote:
> Vitaly Chikunov wrote:
> > Willem,
> > 
> > On Wed, Aug 14, 2024 at 09:53:58AM GMT, Willem de Bruijn wrote:
> > > Christian Heusel wrote:
> > > > On 24/08/14 10:10AM, Adrian Vladu wrote:
> > > > > Hello,
> > > > > 
> > > > > The 6.6.y branch has the patch already in the stable queue -> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3e713b73c01fac163a5c8cb0953d1e300407a773, and it should be available in the 6.6.46 upcoming minor.
> > > > > 
> > > > > Thanks, Adrian.
> > > > 
> > > > Yeah it's also queued up for 6.10, which I both missed (sorry for that!).
> > > > If I'm able to properly backport the patch for 6.1 I'll send that one,
> > > > but my hopes are not too high that this will work ..
> > > 
> > > There are two conflicts.
> > > 
> > > The one in include/linux/virtio_net.h is resolved by first backporting
> > > commit fc8b2a6194693 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4
> > > validation")
> > > 
> > > We did not backport that to stable because there was some slight risk
> > > that applications might be affected. This has not surfaced.
> > > 
> > > The conflict in net/ipv4/udp_offload.c is not so easy to address.
> > > There were lots of patches between v6.1 and linus/master, with far
> > > fewer of these betwee v6.1 and linux-stable/linux-6.1.y.
> > 
> > BTW, we successfully cherry-picked 3 suggested[1] commits over v6.1.105 in
> > ALT, and there is no reported problems as of yet.
> > 
> >   89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
> >   fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> >   9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
> > 
> > [1] https://lore.kernel.org/all/2024081147-altitude-luminous-19d1@gregkh/
> 
> That's good to hear.
> 
> These are all fine to go to 6.1 stable.

FWIW, as we are hit by this issue for Debian bookworm, we have testing
as well from David Prévot <taffit@debian.org>, cf. the report in
https://bugs.debian.org/1079684 .

He mentions that the 9840036786d9 ("gso: fix dodgy bit handling for
GSO_UDP_L4") patch does not apply cleanly, looks to be because of
1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
from 6.2-rc1, which are reverted in the commit.

Regards,
Salvatore

