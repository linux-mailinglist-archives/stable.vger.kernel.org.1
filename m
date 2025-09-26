Return-Path: <stable+bounces-181796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9CBA5295
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 23:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA25A1B24C20
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7B284B3C;
	Fri, 26 Sep 2025 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS/wpUd2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8E1F4E34
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920930; cv=none; b=CkjtE4lLdO+/xQO0ICU7FuYsaSaQ0vw2DoP9111VJ+YryCyBNxfiNfx/V2ZTa/ti10V6oRbvW7LSfiGzU/qHsHAjOhhn8JGNTzprC5Cdk7AGKXDTpxGIHPm3IqybsQzR/hvbutnN/M2EU2cBfnpE1mfNs0KyhkNZvcyKyfE48N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920930; c=relaxed/simple;
	bh=Jc4EjceSLmpDjEcyfGiNWZ65Xn1oM5ndssYe+GwUZgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7wqBBCJA/JIdYTEQWrX2zYz1eDBAak2vhaCeykFN5Kf4skNvbZPKkJxKGdLGpER7yqntTcFiU6P5978AorBsxKOfKvZd1Q0iSbNch5eQgGifVQwgM6tPtZd1DNVRbZtSy8v8H9q0ftw25txZn8cqAiS3LgcufJHb4S58eaQnd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS/wpUd2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758920927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3GVZ1JYDpd64aStls1BI0HpVUBRoCJZmr3t6BifA9A=;
	b=CS/wpUd2ZvFAOyM0+Gmv7RyUCIRg6NfigGil9xuk0asoYzCkgJ+AcZkCJfB9Ce/01FWtq5
	OTN0dOho5VZkH6qM/92j7vxYz+um7SEvG25QizZnqrv8VQ+M3XjhqfVmyfPOoCym+9+5U2
	K/1uHTBrK81lZWxE+3MzlIHdHEN1slg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-fqXoHqTWNZeVuiJcWsg8Ug-1; Fri, 26 Sep 2025 17:08:45 -0400
X-MC-Unique: fqXoHqTWNZeVuiJcWsg8Ug-1
X-Mimecast-MFC-AGG-ID: fqXoHqTWNZeVuiJcWsg8Ug_1758920925
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85641d6f913so584485585a.2
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 14:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758920925; x=1759525725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3GVZ1JYDpd64aStls1BI0HpVUBRoCJZmr3t6BifA9A=;
        b=kgigY7ENM2D6BxdCTWtWZDTF+XpfwvPuhik/mm7dzyGDebPqyK9MHEhAennk5ZA/ek
         IPJSLx7XWT8tS3/C83ElxMc9tGYTaUYM7rgVJNtQYW8ZcSeu7VEgNpNqq4QPROfNrpvG
         kH260UKjLfXuiXB86cWxj9AyX+dbCB0oj792oYuQVcQ0eTSoL/tyQ6xCwlsltGUJ4w2e
         qJloLFNzJi5RsCAdTgaGXcM6rt2glIUBV3LTIivbr5Wz6mBUabZf2CsLOnCCh6X+fXuP
         R48GYp1eSU+hHmJlspDfyhea93g++cy3342Y03vscOTfLiTk6EGvHgyramb8JEuNxjgr
         Bz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1sx+4o3fLKEN1MexJwYZfrfJXJgbAI+eGXkVILGoCWkpdiCCEVkfZ0VjoB+/lRgAFQxTueJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnd6VmVkVblqblgo1wnV2bwRQn/Zm/rPegH5ITOc1QD6sGA5Vb
	rcs1aQs/eTeWRAXMU5eyr7uoQDfWBopAos6EXZqkymNmHUxaGKglrmu1/XF17D6MH8rXaKWBOZL
	tul8cIIjRmOHd8Xbv0cIk/nUdv9KjyKmHG24TZSQRKP3rozGlJG8SwNdsTA==
X-Gm-Gg: ASbGncsPk/wP8yQ+EqcI+m/GjOoTCdaUx+rUqbn7FI0e4UcrZOLSHlLZU0NpIBjSozB
	L3BOZi7hyuA6/UlxlKUphC8EHMZJg9uD7PaxMrnBDxqVGkglLmaKizV1lJ++WJvEZ05P9ORXuds
	1R2BGij3LGnB9qjA5dMJYoBKjYT92JuJR4oEtNZWBwWJXRtzu0kbMrZzvDVKqsJMBo+QotXstqS
	CfeK3koWD/wGwD0jOYlYUJxp7/WHyaAJXakpnV8nU2EUtmjw8LhWKlFFd4kN3aPv4rT5rFdaA2d
	Tu8BtGiFk6cMC6NhV/o9ACqPXcqkFQHMDqN+iN5Ks3GuOmb79V+6TcXiLk+VyuzSQXHAyKqyoy9
	cVZjT4+jnb+Pdsk5XuUHzoNfi3E1B9D0=
X-Received: by 2002:a05:620a:4722:b0:85a:2def:2fe0 with SMTP id af79cd13be357-85ae033d4d8mr1349869285a.22.1758920924972;
        Fri, 26 Sep 2025 14:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJQzW4JZ3je9wirGSfh6XIDEj/iDBCJuS1EQrYgcojfBD4UAa9IhVt5/kN4bppw04xeCyjUw==
X-Received: by 2002:a05:620a:4722:b0:85a:2def:2fe0 with SMTP id af79cd13be357-85ae033d4d8mr1349864685a.22.1758920924446;
        Fri, 26 Sep 2025 14:08:44 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c34da236asm340619385a.68.2025.09.26.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:08:43 -0700 (PDT)
Date: Fri, 26 Sep 2025 17:08:41 -0400
From: Brian Masney <bmasney@redhat.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: ocmem: fix device leak on lookup
Message-ID: <aNcA2SCZMckYmZXb@redhat.com>
References: <20250926143511.6715-1-johan@kernel.org>
 <20250926143511.6715-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926143511.6715-2-johan@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Sep 26, 2025 at 04:35:10PM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the ocmem platform device when
> looking up its driver data.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Also note that commit 0ff027027e05 ("soc: qcom: ocmem: Fix missing
> put_device() call in of_get_ocmem") fixed the leak in a lookup error
> path, but the reference is still leaking on success.
> 
> Fixes: 88c1e9404f1d ("soc: qcom: add OCMEM driver")
> Cc: stable@vger.kernel.org	# 5.5: 0ff027027e05
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>


