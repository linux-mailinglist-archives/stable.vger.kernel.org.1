Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07C716F08
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjE3UqN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 16:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjE3UqM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 16:46:12 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42A08E
        for <stable@vger.kernel.org>; Tue, 30 May 2023 13:46:10 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f6c6320d4eso14241cf.1
        for <stable@vger.kernel.org>; Tue, 30 May 2023 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685479570; x=1688071570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr06SdwCclh2zvxEhUJpXnyPxEiUxaGZRfUn2lWDHfU=;
        b=wgszgCOPzKS/eLro6ja1PmQxsYOjUp8PXM+Swi1b3geif0q8T060pvy1gMVwZtfWOb
         FL9Tyf7b94KpPgOcaGyP5nDYKVAdBX0Re8BzliJbAyEnFwK4+on/hFIxNzGVI9sNMlZs
         MJSXy3b/lOvM5bWZINlP/C4SXsd3dicw63NsJOgHjejKWFPeqv5yMrNe19Rwk9Ii+D7+
         8d6HpD7AbKBen6lc9A+Y2h1hljftzsr8SEcPBnTph3dwlNHc+XDVuR7fm6hrxDsgQYQ+
         GJ0vud2oNQjSJEmbKTgRkKejRzquMcW1dBRk6kQUmZgDudEZ879dggOnwPfpjOD6F5y4
         oZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685479570; x=1688071570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr06SdwCclh2zvxEhUJpXnyPxEiUxaGZRfUn2lWDHfU=;
        b=YMrR8DU1008q3RMROrQk4DANXDRvAih83XHU8lXgPKkaamjyBT256RRsecRAOgJKde
         1GhngNSOjTfuhOfbMstuJyTSdbmfgTbYvYOiQ0KsJIU1dwTEb4hDN+y1kt5goTX+qhOg
         TfEbGybnnaV4jIXHKXGIqdgoDHgrbBiAWM8kxZUOPS4SrRrorxxDLgd194ldjBx0QSz/
         /U4Mz6ZAyS5q6aoRv7W1GGhYj7tPdphCJvkkfLfkSmjpUdsfMkFgzvT3/RcEaXJLKv/D
         6R7MONT4rCwLhztQPZ6K+/5ZO6c23exFlAm9/eGBk9tkhbP+6XT0LmHWc+HHc+pr6p03
         XktA==
X-Gm-Message-State: AC+VfDyYE4c95oi/7zF+81IOYPqa0E7Qqk5VlUCQjw5Uys7xSwK1lsW8
        lhhlu7gV0FOhAqYfdhogvAT0WyQODRy7gv3WdqEhnA==
X-Google-Smtp-Source: ACHHUZ4jJZKLPPo4/StebD/Mknpi3tNY4VHMroMJx9drsU138Agu7XkXbVs4RIR2E01Thou8y3+90/FSSZVQUAlewLU=
X-Received: by 2002:ac8:7e8c:0:b0:3e8:684b:195d with SMTP id
 w12-20020ac87e8c000000b003e8684b195dmr20043qtj.10.1685479569818; Tue, 30 May
 2023 13:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230530193213.1663411-1-oliver.upton@linux.dev>
In-Reply-To: <20230530193213.1663411-1-oliver.upton@linux.dev>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 30 May 2023 14:45:33 -0600
Message-ID: <CAOUHufbUNhnYKqHAffcM82hyJp0vgfFWmFkhzyrx_W4rkGbgkg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 1:32=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> The reference count on page table allocations is increased for every
> 'counted' PTE (valid or donated) in the table in addition to the initial
> reference from ->zalloc_page(). kvm_pgtable_stage2_free_removed() fails
> to drop the last reference on the root of the table walk, meaning we
> leak memory.
>
> Fix it by dropping the last reference after the free walker returns,
> at which point all references for 'counted' PTEs have been released.
>
> Cc: stable@vger.kernel.org
> Fixes: 5c359cca1faf ("KVM: arm64: Tear down unlinked stage-2 subtree afte=
r break-before-make")
> Reported-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

Tested-by: Yu Zhao <yuzhao@google.com>
