Return-Path: <stable+bounces-59232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC59305DE
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 16:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431682828B8
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB4136E09;
	Sat, 13 Jul 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODQfe19G"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4B139CE3;
	Sat, 13 Jul 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720880241; cv=none; b=kv8VfeeDni84Z9e5Nv9p1Iv6AZ0YggQuC/OKYtTnWiJ8j3fOf4i+h1lwRCI+7Kt2eZDIX/VVEJOBARieuOtR/C05r8skOOiuhOXrXCsuO08rX95Q+3g1jkii+Ax4uNAuErIcPPOm0IGE89BDno6pfSujjqXZxByCD18OlUfK5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720880241; c=relaxed/simple;
	bh=XyoETu6aCxO/5MMthKlDDfFnCrA8sNj/WjViFMrSVJs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Soaq6IwUu5gLgPnWxhcDgdbD3UHFH/3XUDH4q97V2Fi9zOx14HBzHLOY3LjIxefpE5CNeTit4i9DIaDol0PRQ4NbYsnIISP8gqaeWQrnRzxtr93yTx4L45Lq+rTNVNuGS5ELAwHa8qrC1Etsr+0/Ukyt6kgwZGvnDqVQRMSVDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODQfe19G; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5dc36b896so22902106d6.1;
        Sat, 13 Jul 2024 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720880239; x=1721485039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cwx4+UgmNI4p5mIoE1u1cA5r41uObm4Tuy2xvPeTXpU=;
        b=ODQfe19GHJrOe9LvJqR2cf5BgJNzu+O0d8oAdqmp3sutO6FAOgOyNZ7gubtd0t2Tyb
         iJKH+ujg6blrQgmGjqK3798ROltlSB+WjzkABJsokA45hb5t7eH7WYMPYAIMRZVHq949
         Y7jealm6lvgWc9LzmXsGigN48fje0AI+dUCI43gyPnBbwS9S6k6yhaD4IT2ThkbHsrV0
         p/u3/58S0NP8bomLE9z6nBbS7PA2DbBiJXsZPZYwkvnQCvRm6Ycj1UdRz3DAp5NPBWMF
         YphFCsgEJH83a+fZMOFapXpmZ0jWhALQR70N00Td/7n1OKYEDt6tGj+u7rpeoB97dYDV
         yXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720880239; x=1721485039;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cwx4+UgmNI4p5mIoE1u1cA5r41uObm4Tuy2xvPeTXpU=;
        b=a+6cV3w95+fu+ZW2kR4Z25H3jATVSbS2yLg8GmFq0qxol5G4wXdYkLRTCsFgqn5YBs
         /caqpgRU9z6zIe/J61E3qfG3hczVrIu0XQfihUvrkYgPvREjzVsrnJqM3MbmoXsvM3bz
         zng5Ja4hso1BDPttg0C5AofmZhVCqQHf3gIZf2oO6/Q4fYtjsUS86iBt5hnm0Zx5hDHX
         o8rg271fAQLQWcQjEfY1z5z7x9aPwXBzh45JHqQeLwiiJZGAmvZYc4A8vT6sRo9sOJsm
         /cLz7SltBtptL5OEp0xUpIVGO1LOQgi6ZxZw8MTWk+hJzaJh/HGdbbr/OqKxorkGW6F7
         mQqw==
X-Forwarded-Encrypted: i=1; AJvYcCWWP3Ys8lFzkop/8ERgWGr9dhujjJfogiqMEltYUq7rt7L5vQsxjfcf7rlxXJGAxBcU3axVRr4m8phTddQduV7PUoAC+voqxbCKZNBznwP+DYPCqG0I2GMowlIS8RHMkwayJzEMo40igz7igxLeDRvMECTfghcp0mGiYlYv
X-Gm-Message-State: AOJu0YwDftxcDJTZNCd/um6UZIr0snLMnwAR927pZ4CYBDIcgLViOn7V
	M8O0hGo5vca7LX+seBhfyZBoqZPqO7lEWtjpnm0HlPa5mWovC+xJ
X-Google-Smtp-Source: AGHT+IH7H5rjgpTeXhkV8ZKuhqf044hmjf8u4JLtx3WTRXGJs2rNHHewoNqxswEH726WJUVDXcGhWQ==
X-Received: by 2002:ad4:5d6a:0:b0:6b5:2aa3:3a7f with SMTP id 6a1803df08f44-6b754bf4498mr108571386d6.20.1720880238551;
        Sat, 13 Jul 2024 07:17:18 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761951610sm5224766d6.27.2024.07.13.07.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 07:17:17 -0700 (PDT)
Date: Sat, 13 Jul 2024 10:17:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kaber@trash.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Chengen Du <chengen.du@canonical.com>, 
 stable@vger.kernel.org
Message-ID: <66928c6d9ea62_27541c294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240713114735.62360-1-chengen.du@canonical.com>
References: <20240713114735.62360-1-chengen.du@canonical.com>
Subject: Re: [PATCH net v10] af_packet: Handle outgoing VLAN packets without
 hardware offloading
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Chengen Du wrote:
> The issue initially stems from libpcap. The ethertype will be overwritten
> as the VLAN TPID if the network interface lacks hardware VLAN offloading.
> In the outbound packet path, if hardware VLAN offloading is unavailable,
> the VLAN tag is inserted into the payload but then cleared from the sk_buff
> struct. Consequently, this can lead to a false negative when checking for
> the presence of a VLAN tag, causing the packet sniffing outcome to lack
> VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
> tool may be unable to parse packets as expected.
> 
> The TCI-TPID is missing because the prb_fill_vlan_info() function does not
> modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
> payload and not in the sk_buff struct. The skb_vlan_tag_present() function
> only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
> is stripped, preventing the packet capturing tool from determining the
> correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> which means the packet capturing tool cannot parse the L3 header correctly.
> 
> Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
> Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengen Du <chengen.du@canonical.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

