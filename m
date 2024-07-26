Return-Path: <stable+bounces-61830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A57E93CE99
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 09:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E36F1C21638
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F5174EFC;
	Fri, 26 Jul 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d61wr32y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2B16F85B;
	Fri, 26 Jul 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977984; cv=none; b=XQy3vCHQe6UTIxNj+I6Mxsc7OuAj/s0Ex9OO9jl2f0e4Cq0TRvoWVPD5H3TmeMRoko/RtCjPv75FD5bLeFh2eOKEYbZOKsb+Q8IMv9NIG7tmFyf1PKZ1DlpSmzOWoujtk1QC4z5/Do5CVo+R8Q5cRcGKp24fRUZWHK4Ih3dcy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977984; c=relaxed/simple;
	bh=wh0OJGTRDs1l3yOJWO2X7RyyUp4t2t1JbQNhSxPlarg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y9zmDn8RQShoYrOo0NEX6LP1pGaEhG5NgN+Bbk6gjS7ud6qpviVWnIUWvZAlFA6uSJndEhBxQm5Qxt/9krOeuVNa9+jjiUxNVUtX0s6lFmjKg1iBuh/ns+KGSNkh+jsAyAR6czfwWUn25wo8O0C13mfWoSZwBXGjkRgT3vWxZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d61wr32y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B41C32782;
	Fri, 26 Jul 2024 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721977984;
	bh=wh0OJGTRDs1l3yOJWO2X7RyyUp4t2t1JbQNhSxPlarg=;
	h=From:To:Cc:Subject:Date:From;
	b=d61wr32yE2+BiAc1KhTwqflv+cEE9gudU2BQurp6quNvI1QwJtDkeo7uN9FAGAuAy
	 9q8z9k9lm9n2a6CXqt4xDCy78btTz66AiJcKyahil+f1hv36hNuqhyBRZ/QIAsme1j
	 nj4e9Gq/9YOGO6WT0XYCzeCP8JTQXr4cEDgtavjw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 5.4 00/44] 5.4.281-rc2 review
Date: Fri, 26 Jul 2024 09:13:00 +0200
Message-ID: <20240726070548.312552217@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.281-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.281-rc2
X-KernelTest-Deadline: 2024-07-28T07:05+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.4.281 release.
There are 44 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 28 Jul 2024 07:05:34 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.281-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.281-rc2

Si-Wei Liu <si-wei.liu@oracle.com>
    tap: add missing verification for short frame

Dongli Zhang <dongli.zhang@oracle.com>
    tun: add missing verification for short frame

Jann Horn <jannh@google.com>
    filelock: Fix fcntl/close race recovery compat path

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Enable headset mic on Positivo SU C1400

lei lu <llfamsec@gmail.com>
    jfs: don't walk off the end of ealist

lei lu <llfamsec@gmail.com>
    ocfs2: add bounds checking to ocfs2_check_dir_entry()

Paolo Abeni <pabeni@redhat.com>
    net: relax socket state check at accept time.

Dan Carpenter <dan.carpenter@linaro.org>
    drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()

Kuan-Wei Chiu <visitorckw@gmail.com>
    ACPI: processor_idle: Fix invalid comparison with insertion sort for latency

Masahiro Yamada <masahiroy@kernel.org>
    ARM: 9324/1: fix get_user() broken with veneer

Edward Adam Davis <eadavis@qq.com>
    hfsplus: fix uninit-value in copy_name

John Hubbard <jhubbard@nvidia.com>
    selftests/vDSO: fix clang build errors and warnings

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices

Christian Brauner <brauner@kernel.org>
    fs: better handle deep ancestor chains in is_subdir()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

Xingui Yang <yangxingui@huawei.com>
    scsi: libsas: Fix exp-attached device scan after probe failure scanned in again after probe failed

Ganesh Goudar <ganeshgr@linux.ibm.com>
    powerpc/eeh: avoid possible crash when edev->pdev changes

Anjali K <anjalik@linux.ibm.com>
    powerpc/pseries: Whitelist dtl slub object for copying to userspace

Yunshui Jiang <jiangyunshui@kylinos.cn>
    net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()

Daniele Palmas <dnlplm@gmail.com>
    net: usb: qmi_wwan: add Telit FN912 compositions

Shengjiu Wang <shengjiu.wang@nxp.com>
    ALSA: dmaengine_pcm: terminate dmaengine before synchronize

Heiko Carstens <hca@linux.ibm.com>
    s390/sclp: Fix sclp_init() cleanup on failure

Chen Ni <nichen@iscas.ac.cn>
    can: kvaser_usb: fix return value for hif_usb_send_regout

Primoz Fiser <primoz.fiser@norik.com>
    ASoC: ti: omap-hdmi: Fix too long driver name

Jai Luthra <j-luthra@ti.com>
    ASoC: ti: davinci-mcasp: Set min period size using FIFO config

Thomas GENTY <tomlohave@gmail.com>
    bytcr_rt5640 : inverse jack detect for Archos 101 cesium

Jonathan Denose <jdenose@google.com>
    Input: elantech - fix touchpad state on resume for Lenovo N24

Arnd Bergmann <arnd@arndb.de>
    mips: fix compat_sys_lseek syscall

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Add more codec ID to no shutup pins list

Michael Ellerman <mpe@ellerman.id.au>
    KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: demote client disconnect warning on suspend to debug

Yuntao Wang <yuntao.wang@linux.dev>
    fs/file: fix the check in find_next_fd()

Masahiro Yamada <masahiroy@kernel.org>
    kconfig: remove wrong expr_trans_bool()

Masahiro Yamada <masahiroy@kernel.org>
    kconfig: gconf: give a proper initial state to the Save button

Eric Dumazet <edumazet@google.com>
    ila: block BH in ila_output()

Hans de Goede <hdegoede@redhat.com>
    Input: silead - Always support 10 fingers

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()

Nicolas Escande <nico.escande@gmail.com>
    wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata

Armin Wolf <W_Armin@gmx.de>
    ACPI: EC: Avoid returning AE_OK on errors in address space handler

Armin Wolf <W_Armin@gmx.de>
    ACPI: EC: Abort address space access upon error

Saurav Kashyap <skashyap@marvell.com>
    scsi: qedf: Set qed_slowpath_params to zero before use

Jann Horn <jannh@google.com>
    filelock: Remove locks reliably when fcntl/close race is detected

Kees Cook <keescook@chromium.org>
    gcc-plugins: Rename last_stmt() for GCC 14+


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/include/asm/uaccess.h                     | 14 +------
 arch/mips/kernel/syscalls/syscall_o32.tbl          |  2 +-
 arch/powerpc/kernel/eeh_pe.c                       |  7 +++-
 arch/powerpc/kvm/book3s_64_vio.c                   | 18 ++++++---
 arch/powerpc/platforms/pseries/setup.c             |  4 +-
 drivers/acpi/ec.c                                  |  9 ++++-
 drivers/acpi/processor_idle.c                      | 40 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  2 +-
 drivers/input/mouse/elantech.c                     | 31 +++++++++++++++
 drivers/input/touchscreen/silead.c                 | 19 +++------
 drivers/misc/mei/main.c                            |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  2 +-
 drivers/net/tap.c                                  |  5 +++
 drivers/net/tun.c                                  |  3 ++
 drivers/net/usb/qmi_wwan.c                         |  2 +
 drivers/s390/char/sclp.c                           |  1 +
 drivers/scsi/libsas/sas_internal.h                 | 14 +++++++
 drivers/scsi/qedf/qedf_main.c                      |  1 +
 drivers/spi/spi-imx.c                              |  2 +-
 fs/dcache.c                                        | 31 +++++++--------
 fs/file.c                                          |  4 +-
 fs/hfsplus/xattr.c                                 |  2 +-
 fs/jfs/xattr.c                                     | 23 +++++++++--
 fs/locks.c                                         | 18 ++++-----
 fs/ocfs2/dir.c                                     | 46 ++++++++++++++--------
 net/bluetooth/hci_core.c                           |  4 ++
 net/ipv4/af_inet.c                                 |  4 +-
 net/ipv6/ila/ila_lwt.c                             |  7 +++-
 net/mac80211/mesh.c                                |  1 +
 net/mac80211/scan.c                                | 14 +++++--
 net/mac802154/tx.c                                 |  8 ++--
 net/wireless/scan.c                                |  8 +++-
 scripts/gcc-plugins/gcc-common.h                   |  4 ++
 scripts/kconfig/expr.c                             | 29 --------------
 scripts/kconfig/expr.h                             |  1 -
 scripts/kconfig/gconf.c                            |  3 +-
 scripts/kconfig/menu.c                             |  2 -
 sound/core/pcm_dmaengine.c                         | 12 ++++++
 sound/pci/hda/patch_realtek.c                      |  5 +++
 sound/soc/intel/boards/bytcr_rt5640.c              | 11 ++++++
 sound/soc/ti/davinci-mcasp.c                       |  9 ++++-
 sound/soc/ti/omap-hdmi.c                           |  6 +--
 tools/testing/selftests/vDSO/parse_vdso.c          | 16 +++++---
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 18 ++++++++-
 45 files changed, 290 insertions(+), 178 deletions(-)



