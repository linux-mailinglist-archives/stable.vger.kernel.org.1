Return-Path: <stable+bounces-231318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO4iEQhVy2moGQYAu9opvQ
	(envelope-from <stable+bounces-231318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:00:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C4F363F6A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D740302A52A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D06367F23;
	Tue, 31 Mar 2026 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctI9LBZk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360AB366065
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933215; cv=pass; b=U1RfWrYyohGvjPk28nVPHG3l7leITOZdFvyaQcsM9vqMOqRRxaAHxMKxeb/YZB0yyVfhJ8CQqymuHzNmYn18iKyPJVGNg8M8otahvo3GfcnVjsc1NvaV7SQbUaFxUUgJxxoAmLe7u3owsh0I2hZnVhoMkfNWNaCNitv7y975l1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933215; c=relaxed/simple;
	bh=qn9GR33IpU25pLfXu1OSUX8rRbknNQbsON2unRJuEZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmWlfmW8TZWcucv35el28rqB5WHi2lPaSFasuFZeHxN0bNYLXHJ/Jecu04+Bl9H8I8s2FsIZmY9hM6W5rFjKfSAeirWK3sRrsevxTHd2jfL/X6etrXqiG4siQZ+zj4wZauMzMmas7vPlBsAXwf+afEcLgRBmiMXqkJDPmpkSdgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctI9LBZk; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7d50516e9so3418217a34.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 22:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774933213; cv=none;
        d=google.com; s=arc-20240605;
        b=aBDpmkLNA+T6i50q5oYH1TP/xSZLp6e79dK/MiUP8bd81B/x/+PvhVT1NzF9+ymuHT
         4W1kfWR3D6dtoToqm/eiuB1V2sP/KLisQmxn8ZTUjy+ZWGH5T4qzKITeWzAoFv34vrIF
         SU87bBwVXkYlPNWrMpdRaD2UnZym0lb0WLFjvFQGPJUR8JfoVttLwsVXCeu4QquVRfVC
         fYhSWHwOSbcw8CU26/yK9s4Z3qbJ2b+vQh2a4gSbn2wa4dSL6iy45kB6ZYKJLD/8KND2
         GdQCq7dT3rDRI0PWdPpGEwD/hKrRJ1Xx+HAXry4oX1fN3uyncx/mt8dFnhC5K0sL2tSV
         QpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qn9GR33IpU25pLfXu1OSUX8rRbknNQbsON2unRJuEZI=;
        fh=/eST8KX+N97Sn80ukHbWn5YCTGdOVkxWSP/6wJxGqO0=;
        b=YNhTkAut1z73YnvTHko5D5CxSINSrtBS6dOZXL48Im98zn5viW/RYL37qy0oqIsKJk
         yz3qmRNk/oWNwf2St3IMwUc6cyiEenrit8/u96mHlwjymDWqU0BLx0EVCkNFObd9017U
         3Tt70hw2uxXcvCXTmTLtUEHrcFYugtKB12K5r0gYRgk1VU9XVeD11jHzdSKUt67GS1MS
         jRkEEuXUoaiNI3w2uYz+3h5ISRzOQPnEBjo9hNboQ3E/sD7vRBSQCtMXUpIcK7YwTJyo
         ASftHogstH/VMDIl3DJigufz7+3CitUJyqMF3mJirmS+jVkaqGa589iItWq/k1oZaLU/
         aFHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774933213; x=1775538013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn9GR33IpU25pLfXu1OSUX8rRbknNQbsON2unRJuEZI=;
        b=ctI9LBZk4mCo+jRYC50HmwAamhxPDbLy6u82T3RWj4BgwkUAMDspaFRUKYM9YBO6mG
         DIB9+ijV6JFgisU9q1O+PrzDYCdgXIlui9tBONhOgKLqs0njwG2XKGUGIUU9Q/6whIKZ
         W3i67VEplsqpqbKc0k3Rt2NwlOVzG5OoPmpARnKnuEZ2J3apMdh2S1DxMIwhN0ho93OY
         XBmsiFiohVFon8mIb+xMRhhd/f9+Pv7NSdADLHaLlitU+LChwqiKt6ahgICSo3QSjZwT
         LoxjrsucSB7MJHhIpkduruN8CJRDEfMViou5Xp2QtABRA7p0O/+zqVwJCtkaETwZZaP+
         8kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933213; x=1775538013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qn9GR33IpU25pLfXu1OSUX8rRbknNQbsON2unRJuEZI=;
        b=kFKT4tr/Fbx/ilWNxS7j9W4lmC/jdlNesHC89qBDkz+Agb3vawKmlf0sa3a1MmQAxd
         N7CZcV5ZkSMCz+WM+7XuNQYiBQ/wg+8Ak1J3cA71LxFFBkCinQp18SiMe67f4tURpeX4
         5M5xoJkW4mJCsme4r3FfY0Yrh+d5SrgY9eDvmUKXuSjJOn6oM4nfjGcPvsiL8EZcVrFz
         zSpU5khfyTJdCwoSfDSaAm29qfRCVbFTtR74Jg1Z3XCX6H82bZKk+9v240+rKxephJpD
         OMTXpwDr//JQx4EyHsirQuQ6kKDUx9FEKA6dVqZiu76RDigRKxcJCNcxlkHBjY92xHHR
         8ZPg==
X-Forwarded-Encrypted: i=1; AJvYcCWRK4ckU212kyprp+I1XyueXjuvebbQ/nMX+Czt5IyO9Nj9roZzGgzFCJaARxb1PRqRWxjGldw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY44rzH5n2B4KKoDczdhatloXGqATPYZeeVSNyWQ7aKTep/3wb
	cxZiO6urVVmasyRigK45oetgpq6E3hmbkk8gZ3Ggi7pgteNmQh44lNYVCFUyNR6hEMTkLAjANUN
	ylw594jTTsUXHABdMJQbUbZWUjNke37U=
X-Gm-Gg: ATEYQzw/pruXc65Qojyz9QzOvbSgPB/yuu0GlF+KmWVlZXOmY+J/y1bGM5lAzAq5W9P
	ic5pO/rbUYlwQ6YhhIKRraMVJY0TowffXF7d8wkh//KV39D6vcsg0LP1MI8LyXDeo/Ka6F7Zd34
	xwgXwQ2BM027kXJd/dBibG1X+i+wispnwLYmC/4tXRtlxYYxeQB85lb5t8LlWkUlz0JtZl+neTa
	efyOhhyXLfeqHDY7PiicTt20GDgwaoeGSkgdAofvsUdI5ONqvmH0aCrYdWAC1E+nrlNa1l/YARh
	sZBJwdU7mgtl4PfbRZgF
X-Received: by 2002:a05:6830:82a9:b0:7d7:455d:1003 with SMTP id
 46e09a7af769-7d9fad9b3d5mr8646097a34.4.1774933213062; Mon, 30 Mar 2026
 22:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314232722.15555-1-mikhail.v.gavrilov@gmail.com> <CH3PR11MB7177D5538C726029D80BA6CEF841A@CH3PR11MB7177.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB7177D5538C726029D80BA6CEF841A@CH3PR11MB7177.namprd11.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 10:00:01 +0500
X-Gm-Features: AQROBzCwLvCBjKMjXnGlDUOQAPoq0K7FN6AFDT1twLET-_2xPEv2urT74LC2vBE
Message-ID: <CABXGCsP+4pSyXHcOBokD5kSuVVa86xhjD+8OTy2woGavovhNKQ@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: fix DMA direction mismatch in release_udmabuf()
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231318-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 94C4F363F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:42=E2=80=AFAM Kasireddy, Vivek
<vivek.kasireddy@intel.com> wrote:
>
> Reviewed-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>
> Thanks,
> Vivek
>

Hi Gerd,

Gentle ping on this patch. It has Vivek's Reviewed-by and fixes a
DMA-API warning present since v5.5.

--=20
Best Regards,
Mike Gavrilov.

