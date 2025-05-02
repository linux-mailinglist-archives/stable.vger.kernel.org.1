Return-Path: <stable+bounces-139519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009CAA7B84
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 23:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C260E4A8051
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 21:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E491F2B8E;
	Fri,  2 May 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="mTIZrZnT"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-3.centrum.cz (gmmr-3.centrum.cz [46.255.225.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD81E5B62;
	Fri,  2 May 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.225.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222645; cv=none; b=NFJy5UuOBII4IO+ICn9KnUst2KIruLO++814dziDd0M6RhYMq7Kj70RHPHg1m/JPBwNUKfV4b93Rt4m5WzwFXLm4FZ79lwNB+4Wfc7GlnFDixAN30Lx693vasnwoW+80E8vyCIUrOxBbpjq2VxPZ6hltMwk30/zMH6XJ3S+hLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222645; c=relaxed/simple;
	bh=spFxqAg8V0e+nLyhUtOHYr+re8J5rfHHZ7tEXoN0alA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r15WQuhWe+ZVCrotISm3nI3tjUxeRg/O+9pvt2O5lRumWiaZKM3PU5Qm5MVBt5do5MdWCZr1wkuNiV1aojx5nVdVS9MerSimLWUWvDwVoPhTVf48j+FUNIu4qzUponATNXGhFlnQQbZAH7DAYyHUS5BfQW+1jEvAzj8nF6/2yXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=mTIZrZnT; arc=none smtp.client-ip=46.255.225.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-3.centrum.cz (localhost [127.0.0.1])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 6AFBF201348F;
	Fri,  2 May 2025 23:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1746222631; bh=YX4Z2wu6WHT3TtCNBsRPyrED6BoxUocx7yjmUHbO4Lc=;
	h=From:To:Cc:Subject:Date:From;
	b=mTIZrZnTyoC2e4DzNJx5iPmanoexOD0yIeM2wpdxurZGamNtSFNiVAUE3yPZMoNiJ
	 MJJY94pudIam/c1fmgOb8X9ie+iWx60k2hzZrCHjN/GVr+Qi2+0Dx0hieG7iYfFWsy
	 sn/lRExmy8cgEtVYwxHlOnygk1/9Zaxcj0nuJkjw=
Received: from antispam37.centrum.cz (antispam37.cent [10.30.208.37])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 69E63201BFD5;
	Fri,  2 May 2025 23:50:31 +0200 (CEST)
X-CSE-ConnectionGUID: m3Nda2qKRzKp4czMMOyS5A==
X-CSE-MsgGUID: AeKj+rjyTSmA+YeG1zR4ZQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2H5AAB0PRVo/0vj/y5aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQAmBSoM0DYFlCYRMpB2BIIxJDwEBAQEBAQEBAQk9FAQBAQMEN?=
 =?us-ascii?q?wEGhDgKizsnOBMBAgQBAQEBAwIDAQEBAQEBAQEBDQEBBgEBAQEBAQYGAQKBH?=
 =?us-ascii?q?YU1Rg2CYgGBJIEmAQEBAQEBAQEBAQEBHQINgScPAUYoDQImAl8SgwIBgi8BN?=
 =?us-ascii?q?BQGsw+BMhoCZdxwAoEjZIEjBoEbLgGITwGEfHAbhR6CDYQOb4EFAYFEgkaDD?=
 =?us-ascii?q?oJpBIItRD4UkwiLI0iBBRwDWSwBVRMNCgsHBYFpAyoLDAsSHBVuMx2CD4Ufg?=
 =?us-ascii?q?g+CBIkOhE0tT4UxgSpHQAMLGA1IESw3FBsGPQFuB5VSg2yBDiyBBROUULMvh?=
 =?us-ascii?q?CWETodLlTIaHhWXUx4DkmWZACKLa4F5lkaEaYF+gX8zIjCDIhIBPxmOR4h8u?=
 =?us-ascii?q?iZ2AgE5AgcBCgEBAwmCO44CgUsBAQ?=
IronPort-PHdr: A9a23:SOfZfhbvAG9kXqFy8mYEnET/LTEt1oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wWPBd2Qsa0f1rSempujcFJDyK7JiGoFfp1IWk1NouQttCtkLei7TGbWF7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4swndrNUajZdtJqovyBbErHtFduVLzm50OFyfmArx6ci38JN/6Spbpugv99RHUaX0fqQ4S
 aJXATE7OG0r58PlqAfOQxKX6nUTSmsZnQNEDhbK4h/nRpv+vTf0ueR72CmBIM35Vqs0Vii47
 6dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3ZPUdhNWCxAGoO8b
 pUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izCJDiH3r0q0gy+kvER/I0RI9EdwAs3raq9r6O7sdX
 +2u0KnFzi/OY+9M1Dvh6oXFdA0qr/GWXbJ3dMrc0VMhGB3ZjlWKtIfqMCma1uITtmiY8uFtU
 vigi3Qkqw5rpzig3N0sh5LTiYIJzlDL7z55zJwpKty5UUN2Z8OvH5RMuS+ALYR2Xt8iTH9yu
 CY80rAKp561ciYFxpg62xLSdv+KfpWG7B/gSOqfITV1iWxhdby/mhu8/ketx+7/W8SozVpHq
 jZIn8XCu3wR2BLe98mKR/1g9Umv3jaP0hrc6uBCIU0slqrUNYQhwrgumZoXq0jDGTX2mErwg
 aSLdUsk4vCl5uvmb7n8uJORN495hhvgPqgwmMGzG+Y1PwgWU2SF5Oix2qfv8VPnTLlWlPE6j
 KbUvIzAKckfp6O0BRJe3Jw55BalFTim1cwVnXwALF1YZh2Kl5PpO1TSIPDgCve/nkisnC9rx
 //YOr3hBY3ALnfGkLv4ZrZ97lJcyBIuwdxC/Z5bFq8OIPTvWk/rqdzYCwU1PBC1wur/CdV90
 J0RWX6XD6KWMa7eq0GE6+IvLuWWeoMZpjTwJ+In6vPulXM5nEUSfait3ZsZcnC4GfFmLl2Db
 nr2gdcOC2IKsRAkTOHxklKCTTpTaGypX64m+j46CZqqDZ3fSYC1nLyBwCC7E4VMZmFGEF+MF
 23kd5+DW/gXdi2SONNhkicfWLe7UY8h0AuiuxP9y7piNubU4DEXtYr/1Nhp4O3ejQs99SZ3D
 8uH1mGCVXt0k3gSSD8q2KBwu1d9xk2f3ql5m/BYD8Bc5+tVUgcmMp7R1+N7BtPzVw/afdeGV
 kymQtO4DjE1VN4xxMUOY0llF9W4kh/DxzaqA6MSl7GTAJw086Tc32X+JspkznbG0bIsj1o4Q
 sRVKWKmhbRz9w/JB47Gi0mZjbqldbwA3C7R82eO1XCBvEJAUA51SqjFWXEfZk3LrdX2/0/CQ
 biuCakhMgRc08GCNqpKatrvjVlcQ/fjItveb3qrm2isHRaI2q+MbI3ydmQSwirdDlEInB0N8
 naYKwc+Ajyso2bfDDx1CVLveFng8OZgp3O9Vk801QaKb09/2LWp5h4Zn/ucS+kc3r4coicut
 y10HEqh39LRE9ePuhBufLtdYdwg+1pHz3zWuBF9PpO6M6BunEIRcwNyv0/2zRV4Fp1AkdQ2r
 HMt1AdyLaOY0FVcdzKXxJzwOaPYKnP0/B+xb67bwU/e0NmI9acV8vg4qEvsvBuvFkU893Vry
 d5V02GT5saCMA1HVZP3T1Zy8h1SpK/TaSp74JnbkTVoMK+ponrB1sgvCe8N1BmtZZFcPbmCG
 Qu0FNcVVOa0L+l/o1W1dFo6Nebx9+ZgNtmlfv6PwoaiIOJph3StnzIUs8hGzkuQ+n8kGabz1
 JEfzqTdh1PfPwo=
IronPort-Data: A9a23:ZRNwXq70WSJdbAup7e76YgxRtM7GchMFZxGqfqrLsTDasY5as4F+v
 jQdWT2OPPnYYWShedp3YIu38khX7ZbTm4IyHgJlrS5kZn8b8sCt6fZ1j6vT04F+CuWZESqLO
 u1HMoGowPgcFyKa+1H0dOC88BGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYHR7zil5
 5Wr/qUzBHf/g2Qpaj9MsfrZwP9SlK2aVA0w7wFWic9j4we2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauO60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 v0W7MDtFl15VkH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwLWsrYhnZnsGM0pGjFuJ+o+EEPfK2FdZK0p1g5Wmx4fcOTpWGWKDW/YYBmjw9gNxUAPOYb
 NhxhThHMEqGOUASfA1NV9RhwY9EhVGmG9FcgFuPpqMy6nL7xRB12aOrO8i9ltmiHJ0Oxx3F/
 T2fl4j/KjgXF97c0ziUzkmpr6z+kAyiSrhOJoTto5aGh3XWnAT/EiY+T0qyp7+jjUSzQc5EA
 0UO/2wlqq1a3EWxTdD4VgeQqWKAtwVaUMg4O/1qtimOx7DS7gLfAXILJhZFado7pIozQBQpy
 FaCnJXuHzMHmLSWUXe18raSsCP3Ny8IK2MLeS4DS00C+daLiJE+iFfDQ8huFIaxj8bpAnfgz
 jaSti88ir4Py8kR2M2T8VnZgj6EvJXFTgcpoA7QWwqN6gJ/eZ7gZIGy71XfxehPIZzfTVSbu
 nUA3c+E44gmFo2EniiAaPsCEavv5PufNjDYx1l1EPEcGy+FpyDlJ90NpmskewE2b67oZAPUX
 aMagisJjLc7AZdgRfUfj16ZYyjy8ZXdKA==
IronPort-HdrOrdr: A9a23:juBlLKMTlAGubcBcTtCjsMiBIKoaSvp037Dk7SxMoHtuA6mlfq
 GV7ZYmPHDP5gr5NEtLpTniAtjifZq/z/9ICOAqVN/IYOCMggSVxe9ZgLcKuweBJxHD
X-Talos-CUID: 9a23:D+Iz1mOs8xwLWe5DXXJB+EdOA+MfYF7FkHzCBmqfGF00YejA
X-Talos-MUID: =?us-ascii?q?9a23=3ArFljWw25Exhfum1n9yc06o7XrzUjyqmNCgMXk4Q?=
 =?us-ascii?q?6gMytdh19FG6PtmiFe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,257,1739833200"; 
   d="scan'208";a="103135371"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam37.centrum.cz with ESMTP; 02 May 2025 23:50:30 +0200
Received: from localhost.localdomain (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id A6B10100AE2B1;
	Fri,  2 May 2025 23:50:30 +0200 (CEST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
Subject: [PATCH v2 0/1] mm: Xen PV regression after THP PTE optimization
Date: Fri,  2 May 2025 23:50:18 +0200
Message-ID: <20250502215019.822-1-arkamar@atlas.cz>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I recently discovered an mm regression introduced in kernel version 6.9
that affects systems running as a Xen PV domain [1]. Original fix
proposal wasn't ideal, but it sparked a discussion which helped us
fully understand the root cause.

The new v2 patch contains changes based on David Hildenbrand's proposal
to cap max_nr to the number of PFNs that actually remain in the folio
and to clean up the loop.

Thanks,
Petr

[1] https://lore.kernel.org/lkml/20250429142237.22138-1-arkamar@atlas.cz

Petr Vaněk (1):
  mm: fix folio_pte_batch() on XEN PV

 mm/internal.h | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

-- 
2.48.1


