Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8937A4C96
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjIRPhG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIRPhF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 11:37:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33122D40
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 08:32:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c43b4b02c1so18822835ad.3
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695050957; x=1695655757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abFxBMLmE6je9n8ycRrpCecvQlEihPWZd75zj0mwVu4=;
        b=EDhQGbodftuX73rYdR+tx5Pq4K1UkSoQcqUdaxgRfTX/w0QUxtnKxt5U8DWaVrpTbS
         UzJlpoB9KuPO1xen69/QOA/odWqR9Y6pqEK0TFtVYZsKI7zFMhdIp6ZCR65Ku+W9oAcr
         XdQjUK0q8YQrdQSwoi8BJGw9q6kTOcPdnB8r8utjr3nrzeD9QS8S9VqrR//T8Um28l/I
         Rdt+s36QnjaNhVl5bdSJ+fsULH2p2jHsNRFIiBR8pJL01EA/+9hTdEt9LUcKvJSp3Scv
         FTAm36NUUgzKFzHD9+NOSCpMiy+HDfC8ygj0GTg6uWJNt4Suf9FSjwoEhZxkvZGRUe2V
         O+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050957; x=1695655757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abFxBMLmE6je9n8ycRrpCecvQlEihPWZd75zj0mwVu4=;
        b=cgwu0sWCnrfpP5QTA3Z9aQukXVlSkPWSbsjbdgfrgb/Mg4LbXEIAN6M41hof32m8EQ
         VirXx24l6g+NkcxLJGOyAEGKgDnr4crnble2ZfoIMvHr53OxY6lo4jfa7PGY/r3cUPrd
         o9UpmuvQRnKGaESAx/2AauEJ0/GUmGJzUzUPny5DUMhscbCP/vhjBhz7lUEx9oGM/L8r
         X5dIuEdM0WQNyg8hAcyhWlumAOHVsGspZPJgdFVm2JBhIPokTn4sYBRz2nCzf1OubR2s
         pAUdSt9Q4/4H+LRvZbDkhK7MRDlDKhaWze+uqdDC2SB8YUX3AyfE34LqDvZdbnfbntcT
         eD5Q==
X-Gm-Message-State: AOJu0Yz7CaPrwNrZn4QdgPHdhRZeTGXEIG10pYtZIB+RRTuKQXzol4nf
        VzRW7CfMdpehcjvbWKRXoMhGsw==
X-Google-Smtp-Source: AGHT+IGkPPsGvQqcYFLf0KZSE5Yj/heR0ybdwdNcnZm27VTPIfhhzJx659QcINaY6lgh47ehEn1O7Q==
X-Received: by 2002:a17:902:9b83:b0:1b3:8862:9823 with SMTP id y3-20020a1709029b8300b001b388629823mr7240901plp.28.1695050957414;
        Mon, 18 Sep 2023 08:29:17 -0700 (PDT)
Received: from PF2LML5M-SMJ.lan ([103.175.14.91])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902968600b001bdcde49bc3sm8407895plp.119.2023.09.18.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:29:17 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     gregkh@linuxfoundation.org
Cc:     guojinhui.liam@bytedance.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, lkp@intel.com, rafael@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v6] driver core: platform: set numa_node before platform_device_add()
Date:   Mon, 18 Sep 2023 23:29:12 +0800
Message-Id: <20230918152912.378-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918134527.252-1-guojinhui.liam@bytedance.com>
References: <20230918134527.252-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> On Mon, Sep 18, 2023 at 09:45:27PM +0800, Jinhui Guo wrote:
> > Setting the devices' numa_node needs to be done in
> > platform_device_register_full(), because that's where the
> > platform device object is allocated.
> > 
> > Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> > Cc: stable@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Where did I provide this tag?

I appologize to it. I just misunderstand what it means. I will drop it out soon.
