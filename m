Return-Path: <stable+bounces-107899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB37A04AFB
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FCE161236
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB51DF99B;
	Tue,  7 Jan 2025 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3zHsQdk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E139156F3C;
	Tue,  7 Jan 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281913; cv=none; b=VbDTm4Z5Pz4P7N2i68JjoMKSg4tdP1osl7JFPMT7kWm/sNuGhX7hVrMZazyYjhRr6zV8IT1r2xFj3QJo9C8p3zk+h3Sy7rjMjJM4G3F8AxtkdwjR3HkoIN7C8/+cJ/viFrdlkg2m4IcpnFsWUbGN2o5m1kxN/1unlq8aB6oZQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281913; c=relaxed/simple;
	bh=VDB3aV1ej46szrkfi53J6GzK+l2St2AiYjZTvcL8UqQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cBc1QeBIJbp9Vakmvu6w7F5Fg5gPbkuchxwYIPTfa9Ay9b2L4oU3Q2fuH4c4vfn+FUgMyZEtDtu7tZeZPP61B/j/Z65dEWiNgIqzggMzvHzHc8uPYiG4QkozUUFo8UGLqsFGDj/dXEep29/B5MSwx/Ht+lDoSNN1ik/KiPqZhxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3zHsQdk; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso140238156d6.3;
        Tue, 07 Jan 2025 12:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736281911; x=1736886711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85377DzcGMIom6ywJTM4uE9HXXnDyuY0I3IvqpFKUiw=;
        b=O3zHsQdk/JcmDNDbSuvurJ/14XA3K2BiDHO4P6IagJqePOZzr/2k+0U+9YZ8/E2ZxN
         5Jhb7u8ebVE8/tLiR2RfWHFspFbfuHzKKWkZ8fWKShmEiiA7eRt1AJ2vPpWh9IK1AH8U
         6lNqyOxoSws4YYC0x61hsKEctIudrtXHrWDH3raCpV4yAKPNSbSKBSYNfAsnUr+SX1Z1
         sXKBRu0h6RBCotr/ApeMhKbPnVi7M3cVHapLwksDgpH7Wmo45dYs2D27u7Zj9Cylbh5q
         siEGf/dF6/AHyXfWsdmWbCi4gkDKLcSxVbSQGQ2qsyRi3cndzMv53BFpw0RtnEtmyIvy
         UNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736281911; x=1736886711;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=85377DzcGMIom6ywJTM4uE9HXXnDyuY0I3IvqpFKUiw=;
        b=qSjR3AT5ShWa3LNrWgavLjJZWKC7D1oRWzCZw1SCpIWaQVpPkDPHjZHn3lJ3+LVjHn
         xL3TsuIvQdlYYolMs9ZKbLOw0hjYxIQ/5NFjY2ABisOHUmp1uHW99wPiJExvHTDWJK9f
         dCUoIhKo/sdnVPFoj+obXPatV4h3AlrnfhMNR45CqkQAOZxxOzSWv2a6vfhHmsjd4zG6
         Zd1J/2RZ4A3NVp5smTJN5336jjmpmgCm22kf/IG1IV/jUFkivqT3EgNKRtAHctPp6WB8
         5fC1MRXL9vCHBmXKXeE2qLIMDZCjaLH6rveCqRVy+Zfzvpj60KIlhkwD1y2PR10IGgv/
         w2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQTHirU+zylTeOTrY2Iz379zk3Shg/VafJhrAczvDHzN8eF4wQUCC3sW4y3Zd6VzYgcDgbRo6M@vger.kernel.org, AJvYcCW2hLvEEs7JfVNcZCG/BVRM1UYmsuE4oHHQ+wOsox25Cmo448CyuTwX0+zesinlPle27TUmqew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmGUzSq7XRQxA8X7IgNY/ZHlwQmiP8yjaR8PtEi+ZcbEZcfzJ
	Pfk60OzQZsS+T/U6nau6ioPw54lMpv7dENhTjTrjq/XnJRYYqa7c
X-Gm-Gg: ASbGncuJTIRI/36/WjOj1l3FnJtpyHdS8ofwZXFo0ofcBKGJ+cimbwHg5zLG6cqsGOz
	8gOkfUgrkQWtRD/RCNXKB+W+EJZvAXBatAnBAr9n+ZChAfTP2PMr3EaMwdJ4rU9j+Kpud5S7wcc
	pN/4u9jGQPo+Lv6uwF2fKl9jpaPjssgrTDrGTpi0HCgyQwC1tFF/LPyknPl9w8fWe6gsRrhK+2H
	A4ybcwFsvHj2M+uYAgTA4aVaji5uYgDoFXKc+mZICjupRcuL30mqBzBUnP1/Q1QDDqrQ8ETl0Fb
	dQmuyXTCIYzpOspsttRP3oVKKw5S
X-Google-Smtp-Source: AGHT+IFD9HQCI27E9RkmKKPdAhPsQjdr8SjFufL7JehCn73t+MgchtXglJUSJN8iI6+a8WN/v+wUow==
X-Received: by 2002:a05:6214:5b89:b0:6d8:86c8:c2a9 with SMTP id 6a1803df08f44-6df9b2cfae6mr7929316d6.31.1736281911032;
        Tue, 07 Jan 2025 12:31:51 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18208102sm184228416d6.128.2025.01.07.12.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:31:50 -0800 (PST)
Date: Tue, 07 Jan 2025 15:31:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 stable@vger.kernel.org, 
 jdamato@fastly.com, 
 almasrymina@google.com, 
 amritha.nambiar@intel.com, 
 sridhar.samudrala@intel.com
Message-ID: <677d8f3618080_2821742942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250107083609.55ddf0d6@kernel.org>
References: <20250106180137.1861472-1-kuba@kernel.org>
 <677d27cc5d9b_25382b294fd@willemb.c.googlers.com.notmuch>
 <20250107083609.55ddf0d6@kernel.org>
Subject: Re: [PATCH net] netdev: prevent accessing NAPI instances from another
 namespace
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 07 Jan 2025 08:10:36 -0500 Willem de Bruijn wrote:
> > > +/* must be called under rcu_read_lock(), as we dont take a reference */  
> > 
> > Instead of function comments, invariant checks in code?
> > 
> > Like in dev_get_by_napi_id:
> > 
> >         WARN_ON_ONCE(!rcu_read_lock_held());
> 
> Can I do it as a follow up? Adding the warning to napi_by_id()
> reveals that napi_hash_add() currently walks the list without
> holding the RCU lock :)

Ah I should have noticed that :) Of course, or ignore in this case
then.

